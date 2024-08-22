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
!  Define the calc mode:

!
Kjob = 1
!

      
!   Initialize calc 
CALL calcinit()

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

!
!   Begin the 2-minute interval processing loop
DO J = 1, Intrvls2min    ! 2-minute interval loop
!DO J = 1, 2    ! 2-minute interval loop
!
!   Create the observations and compute the delays for the I'th scan.
   CALL dDRIVR(Num_scans,J)

!  Output computations to the IM table for this 2-minute interval.
   Call d_out2(1,J)   
   
ENDDO


end program testCalc11
