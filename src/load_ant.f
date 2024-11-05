      integer*4 function LOAD_ANT_F(SITE_NAME, ANT_AXIS, AXIS_OFF, X, Y, Z)
      implicit none

      INCLUDE 'd_input.i'
      INCLUDE 'cmxst11.i'

      CHARACTER*(*) SITE_NAME
      Character*(*) ANT_AXIS
      REAL*8 AXIS_OFF, X, Y, Z

      NUMSIT = NUMSIT + 1

      IF (NUMSIT.GT.Max_stat) THEN
         LOAD_ANT_F = -1
      ELSE
        Sites(NUMSIT) = SITE_NAME
        Axis(NUMSIT) = ANT_AXIS
        SITAXO(NUMSIT) = AXIS_OFF
        SITXYZ(1,NUMSIT) = X
        SITXYZ(2,NUMSIT) = Y
        SITXYZ(3,NUMSIT) = Z
        LOAD_ANT_F = 0
      ENDIF

      RETURN

      END
