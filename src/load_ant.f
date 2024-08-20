      integer*4 function LOAD_ANT(SITE_NAME, ANT_AXIS, AXIS_OFF, X, Y, Z)
      implicit none

      INCLUDE 'd_input.i'
      INCLUDE 'cmxst11.i'

      CHARACTER*(*) SITE_NAME
      Character*(*) ANT_AXIS
      REAL*8 AXIS_OFF, X, Y, Z

      NUMSIT = NUMSIT + 1

      IF (NUMSIT+1.GT.Max_stat) THEN
         LOAD_ANT = -1
      ELSE
        Sites(NUMSIT+1) = SITE_NAME
        Axis(NUMSIT+1) = ANT_AXIS
        SITAXO(NUMSIT+1) = AXIS_OFF
        SITXYZ(1,NUMSIT+1) = X
        SITXYZ(2,NUMSIT+1) = Y
        SITXYZ(3,NUMSIT+1) = Z
        LOAD_ANT = 0
      ENDIF

      RETURN

      END
