!     Include file param11.i 
!
!     ******************************************************************
!     *      CALC 11 Version                                           *
!     ******************************************************************
!
!     JPL_DE421 is the path name for the JPL ephemeris file.
!
      Integer*4   N_RECL_JPL
      PARAMETER ( N_RECL_JPL =    4 )
      Integer*4    K_SIZE_JPL
      PARAMETER ( K_SIZE_JPL = 2036 )
      Integer*4   I_RECL_JPL
!
      CHARACTER  JPL_DE421*128
      PARAMETER (JPL_DE421 = '/Users/phi196/code/calc11/share/calc11/DE421_little_Endian' )
!
      CHARACTER A_TILTS*128
      PARAMETER ( A_TILTS = '/Users/phi196/code/calc11/share/calc11/tilt.dat' )
!
      CHARACTER OC_file*128
      PARAMETER ( OC_file = '/Users/phi196/code/calc11/share/calc11/ocean_load.coef' )
!
      CHARACTER OPTL_file*128
      PARAMETER (OPTL_file = '/Users/phi196/code/calc11/share/calc11/ocean_pole_tide.coef' )
!
!  Leap seconds file (Not needed by difx)
      CHARACTER DFLEAP*128
      PARAMETER ( DFLEAP =  '/Users/phi196/code/calc11/share/calc11/ut1ls.dat' )
!
