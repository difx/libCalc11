      SUBROUTINE SET_TIMES(MJDStart, MJDStop)
      implicit none

      INCLUDE 'd_input.i'
      INCLUDE 'cmxut11.i'

      REAL*8 MJDStart, MJDStop, MJDFrac
      integer*2 hour, min
      integer*4 MJDWhole
      real*4 sec

      Xintv(1) = MJDStart + 2400000.5D0
      Xintv(2) = MJDStop  + 2400000.5D0

      MJDWhole = INT(MJDStart)
      MJDFrac = MJDStart - MJDWhole

      call mjd2cal(MJDWhole, StartDay, StartMo, StartYr)
      call timhms(MJDFrac, hour, min, sec)
      StartHr  = hour
      StartMin = min
      StartSec = int(sec)
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

! name        timhms
!
! function  To compute the time hours, minutes, seconds from the time in days
!
! call
      subroutine timhms(time, hour, min, sec)
      implicit none
      real*8    time    ! Time in day fraction
      integer*2 hour, min
      real*4    sec
!
! author   D McConnell
!
! date     5-JUN-1989
!
! refe     time, portable
!
      double precision dsec

      dsec = time*86400.0
      hour = int(dsec/3600.0d0)
      dsec = dsec - hour*3600.0d0
      min  = int(dsec/60.0d0)
      sec = dsec - min*60.0d0
      return
      end


