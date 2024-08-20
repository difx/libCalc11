      integer*4 function LOAD_EOP(MJD, TAIUTC, UT1UTC, XPOLE, YPOLE)
      implicit none

      INCLUDE 'd_input.i'
      INCLUDE 'cmxut11.i'
      INCLUDE 'cmwob11.i'

      INTEGER*4 MJD, NumEOP, TAIUTC
      REAL*4 UT1UTC, XPOLE, YPOLE

      NumEop = WOBIF(3)+1

      IF (NumEop.GT.20) THEN
         LOAD_EOP = -1
      ELSE
        UT1PT(NumEop) = TAIUTC - UT1UTC
        XYWOB(1,NumEop)  = XPOLE * 1.D3
        XYWOB(2,NumEop)  = YPOLE * 1.D3

        if (NumEop.EQ.1) THEN
!         Setup WOBIF and UT1IF arrays
          WOBIF(1) = MJD + 2400000.5D0
          UT1IF(1) = WOBIF(1)
          WOBIF(2) = 1.d0
          UT1IF(2) = 1.d0
          UT1IF(4) = 1.0D0 
          Xleap_sec = TAIUTC
        endif
        WOBIF(3) = NumEop
        UT1IF(3) = NumEop
        LOAD_EOP = 0
      ENDIF

      RETURN

      END
