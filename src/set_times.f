      SUBROUTINE SET_TIMES(MJDStart, MJDStop)
      implicit none

      INCLUDE 'd_input.i'
      INCLUDE 'cmxut11.i'

      REAL*8 MJDStart, MJDStop, MJDFrac
      integer*2 hour, min, sec
      integer*4 MJDWhole

      Xintv(1) = MJDStart + 2400000.5D0
      Xintv(2) = MJDStop  + 2400000.5D0

      MJDWhole = INT(MJDStart)
      MJDFrac = MJDStart - MJDWhole

      call mjd2cal(MJDWhole, StartDay, StartMo, StartYr)
      call timhms(MJDFrac, hour, min, sec)
      StartHr  = hour
      StartMin = min
      StartSec = sec
      ScanDur = (MJDStop-MJDStart)*(24*60*60)
      RETURN

      END


!+
! name          CALDAY
!
! function      returns the calendar date from the Julian Day number
!
! call
      subroutine calday(julday, iday, imon, iyear)
      implicit none
      real*8     julday ! Julian Day number
      integer*4  iday,  imon, iyear  ! returned day, month, year
!
! author        PA Hamilton
!
! date          22-Apr-87
!
! refe          time, portable
!-
      double precision   d, y, j
      integer            ij, iy, im, id
      j = ((julday-1721119.0d0)*4.0d0)-1.0d0
      y = j/146097.0d0
      y = y-dmod(y,1.0d0)
      j = j-y*146097.0d0
      d = j-dmod(j,4.0d0) + 3.0d0
      ij = idint(d/1461.0d0)
      d = (d+4.0d0 - (ij*1461.0d0))/4.0d0
      d = d-dmod(d,1.0d0)
      d = d*5.0d0-3.0d0
      im = idint(d/153.0d0)
      id = (idint(d+5.0d0) - (153*im))/5
      iy = idint(100.0d0*y) + ij
      if (im.ge.10) goto 11
      im = im+3
      goto 12
   11 im = im-9
      iy = iy+1
   12 iday = id
      imon = im
      iyear = iy
      return
      end

      subroutine mjd2cal(MJD, day, month, year)
      implicit none
      integer*4 MJD, day, month, year, jd, temp1, temp2
      
      jd = MJD + 2400001

      temp1 = 4*(jd+((6*(((4*jd-17918)/146097)))/4+1)/2-37);
      temp2 = 10*((MOD(temp1-237,1461))/4)+5;

      year = temp1/1461-4712;
      month = MOD(temp2/306+2,12)+1;
      day = MOD(temp2,306)/10+1;

      return
      end

      subroutine timhms(time, hour, min, sec)
      implicit none
      real*8    time            ! Time in day fraction
      integer*2 hour, min, sec

      integer :: total_sec, rem_sec

!     Convert to total whole seconds (nearest integer)
      total_sec = nint(time * 86400.0d0)

!     Break down into h/m/s using pure integer math
      hour     = total_sec / 3600
      rem_sec  = total_sec - hour * 3600
      min      = rem_sec / 60
      sec      = rem_sec - min * 60
      return 
      end subroutine timhms
