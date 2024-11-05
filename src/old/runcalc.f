      subroutine runcalc (mjdstart, mjdstop)
      implicit none

      INCLUDE 'd_input.i'
      INCLUDE 'cmxut11.i'
      real*8 mjdstart, mjdstop
      integer*4 J

      call set_times(mjdstart, mjdstop)

      call d_out1(1)

      call dSCAN(1, 1)

!
!   Begin the 2-minute interval processing loop
      do J = 1, Intrvls2min     ! 2-minute interval loop
        call dDRIVR(1,J)

!  Output computations to the IM table for this 2-minute interval.
        call d_out2(1,J)   
   
      enddo
      
      return
      end

