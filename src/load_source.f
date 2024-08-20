      integer*4 function LOAD_SOURCE( NSRC, SRC_NAME, SRC_RA, SRC_DEC)
      implicit none

      INCLUDE 'cmxsr11.i'

      INTEGER*4 NSRC
      CHARACTER*(*) SRC_NAME
      REAL*8 SRC_RA, SRC_DEC

      Character*20 SrcName(MAX_ARC_SRC)
      Equivalence (LNSTAR(1,1), SrcName(1))

      IF ( NSRC .GT. MAX_ARC_SRC ) THEN
         LOAD_SOURCE = -1
      ELSE
        SrcName(NSRC) = SRC_NAME
        RADEC(1,NSRC) = SRC_RA
        RADEC(2,NSRC) = SRC_DEC
        LOAD_SOURCE = 0
      ENDIF

      RETURN

      END
