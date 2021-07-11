#!/bin/bash
bold=$(tput bold)
normal=$(tput sgr0)
echo "Specify path for db folder:"
echo > Go to  ${bold}db${normal} folder and run ${bold}pwd${normal}, then copy the path here.
 read  s
 sleep 1.5
cat > Eatools_db.f90 << EOF
Subroutine databank(id,yesno)
implicit none
character(len=20) ::id
character(len=1) ::yesno
 character(len=20)::id0 
character(len=20), DIMENSION(20000000) ::id2,id3 
!character(len=50), DIMENSION(10000) :: c1,c2,c3,c4,c5,c6
real, DIMENSION(10000000)::c1,c2,c3,c4,c5,c6,cc
integer::i,j,stat
!read(*,*)id 
     call system("clear")
 open (12,file='$s/All_2ID_cop.csv')
do  i=1,13122
   read(12,* )id2(i)
   if (id2(i)==id )then
     write(*,*)"Cij of ",id2(i),"compound is:  "
     write(*,*)"======================================================================="
     cc(1)=i
   endif
enddo
 close (12)

 i=0
 open (11,file='$s/Cijs.binery')
do  i=1,2043900
   read(11,'(Z16)',IOSTAT=stat )c1(i) ,c2(i),c3(i),c4(i),c5(i),c6(i)
 !   write(14,'(B64)')c1(j) ,c2(j),c3(j),c4(j),c5(j),c6(j)
   if (stat<0) exit
enddo
  close(11)
  
 open (14,file='Cij-id.dat')
 cc(2)=6*cc(1)-5
 cc(3)=6*cc(1)
     if (c1(cc(2))==0 )then
      WRITE(*,*)"----------------------------------------------"
      write(*,*)"Sorry! This ID was not found in our database  "

      yesno='N'
      goto 1258
      else
      yesno="Y"
   endif
 do j=cc(2), cc(3)

 write(*,"(7F12.6)")c1(j) ,c2(j),c3(j),c4(j),c5(j),c6(j)
 write(14,"(7F12.6)" )c1(j) ,c2(j),c3(j),c4(j),c5(j),c6(j)
enddo
 close(14)
      write(*,*)"======================================================================="
!1361 WRITE(*,*) "not found data-bank file!"
1258 END Subroutine

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

EOF
echo

cat > Eatools_api.f90 << EOF
subroutine aip_get_online(mpid)
implicit none
character (len=175), dimension(17) :: char3
character (len=16)                 :: key,mpid
INTEGER                            :: i
key='32O9CtVDAwGz8UZk'
open(12, file="$s/api.bin")
open(13, file="aip.py")
 do i=1,12
    read(12,"(Z)") char3(i)
enddo 
close(12)
write(13,"(A)") '#!/usr/bin/env python3'
write(13,"(3A)")"id_com='",trim(mpid),"'"
write(13,"(3A)") 'api_key= "',key,'"'
do i=2,12
    write(13,"(A)")char3(i)
enddo
close(13)
End subroutine

EOF
echo

echo ${bold}The path was well documented${normal}
