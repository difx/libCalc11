program testCalc11
implicit none


INCLUDE 'cuser11.i'
INCLUDE 'd_input.i'
INCLUDE 'cmxut11.i'

!      Character*132 rmIM
!      CHARACTER*128 Calcfiles(2000), IMfiles(2000)
!      Integer*4 ILU, I, J, Num_scans, K, ierr, Kjob
!      Integer*4 lu_out, fd_out
!
Integer*4 Kjob, Num_scans, J

Logical  exist

!
! 1.2.8 PROGRAM VARIABLES -
!           ILU  - The message LU, set to 6. [Not used anywhere?]
!
! 1.2.9 PROGRAMMER - David Gordon 01/15/2013
!      Jan. 2013  DG - dmain.f created for the difx version of calc11. 
!      Mar. 2014  DG - Moved C_mode definition to dmain.f and cmain.f.
!      Jan. 2015  DG - Modified for multiple scans and multiple phase centers.
!
!     MAIN Program Structure
!
!  Define the calc mode:
C_mode = 'difx  '
!
Kjob = 1
!

write(6,'("*6*UT1IF(4) ",4F15.6)') UT1IF

      
!   Initialize dCALC 
CALL dSTART11(Num_scans, Kjob)

write(6,'("*7*UT1IF(4) ",4F15.6)') UT1IF
!
!   Initialize the model modules and the necessary utilities.
CALL dINITL(Kjob)
!
!  Create and begin writing the IM file:
CALL d_out1(Kjob)
!

Num_scans = 1
!  Get scan information for the I'th scan
CALL dSCAN(Num_scans, Kjob)

write (*,*) "DEBUG: Intrls2min= ", Intrvls2min
!
!   Begin the 2-minute interval processing loop
!!DO J = 1, Intrvls2min    ! 2-minute interval loop
DO J = 1, 2    ! 2-minute interval loop
!
!   Create the observations and compute the delays for the I'th scan.
   CALL dDRIVR(Num_scans,J)

!  Output computations to the IM table for this 2-minute interval.
   Call d_out2(1,J)   
   
ENDDO


end program testCalc11
