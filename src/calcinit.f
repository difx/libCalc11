      SUBROUTINE CALCINIT_F ()
      IMPLICIT None
!


!      Common blocks used -
!
      INCLUDE 'ccon.i'
!       Variables 'to':
!         1. ILUOUT - A flag controlling output.
!
      INCLUDE 'cmxst11.i'
!       Variables 'to':
!         1. NUMSIT    - The total number of sites in the data base.
!         2. Zero_site - The site number of the site at the geocenter.
!
      INCLUDE 'cmxsr11.i'
!       Variables 'to':
!         1. NUMSTR - The total number of stars (radio sources) in the
!                     data base.
!
      INCLUDE 'cmxut11.i'
!       Variables 'to':
!         1. Xintv(2)    - First and last Julian Date of data in the
!                          current data base.
!         2. Intrvl(5,2) - First and last time tag of data in the current
!                          data base. (First index: year, month, day,
!                          hour, minute. Second index: first, last.)
!
      INCLUDE 'param11.i'
!       Variables from:
!         1. A_tilts    - Antenna tilts file name.
!         2. OC_file
!         3. DFLEAP
!         4. OPTL_file
!         5. JPL_DE421
!
      INCLUDE 'd_input.i'
      INCLUDE 'cuser11.i'
!
      INCLUDE 'c2poly.i'
      INCLUDE 'cmwob11.i'
!
!
      Real*8  ATMUTC(3), ROTEPH(2,20), A1UTC(3), A1DIFF(3)
      COMMON / EOPCM / ATMUTC, ROTEPH, A1UTC, A1DIFF
!       VARIABLES 'TO':
!         1. ROTEPH(2,20)- The array which contains the epochs at which
!                          TAI - UT1 is desired. The entries are:
!                          1) JD at 0:00 hours UTC,
!                          2) The fraction of a UTC day from 0:00 hours
!                          to the desired epoch.
!
      Real*8    XCALC
      Integer*2 NFLAG,NFLAGC,loadm(8),LFILE(3)
      COMMON /STACM/ Computing_center,XCALC,NFLAG,NFLAGC,loadm,LFILE
!
!     Integer*4 gethostname, ierr4
      Character*64 Computing_center
      Character*6 C_LFILE
      Equivalence (C_LFILE,LFILE)
!
!       Variables 'from':
!         1. loadm(8)  - The load module compilation date message.
!         2. NFLAG     - The total number of CALC flow control and debug flags.
!         3. LFILE(3)  - The name of the CALC control file.
!         4. XCALC     - The CALC version number.
!
!   Program specifications -
!
      Integer*4  IFLAG(62)
      Integer*2  LCALC(40), LFCIO(40), LHIST(66), LNAME(5), LNAMO(5), &
     &           IBUF(40)
      CHARACTER LNAME_chr*10, LNAMO_chr*10, LFCIO_chr*80, LHIST_chr*132
      CHARACTER*80 CBUF
      EQUIVALENCE  ( IFLAG(1),  KATMC ),  ( LCALC(1), LHIST(1) ), &
     &             ( IBUF, CBUF), (LNAME,LNAME_chr), &
     &             ( LNAMO,LNAMO_chr), (LFCIO,LFCIO_chr), &
     &             ( LHIST,LHIST_chr)
      Integer*4 N, MXUTPM, IK, KJ
!      Integer*4 IMNTHS(12)
!      DATA IMNTHS /31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31/
!
!     Program variables -
!         1. IFLAG(NFLAG) -  The variable used to initialize all flow
!                            control and debug output flags.
!         7. Intrvl(5,2)  -  First and last UTC tag for data in the current
!                            data base. (First index - year(2 digits),
!                            month(1-12), day of month, hours, minutes)
!
!     Programmer - David Gordon Jan-Apr, 2013 
!
      C_mode = 'difx  '

      ILUOUT = 0
      MXUTPM = 20

      I_out = 0
      IM_out = 1
      Verbose = 0
      SpOffset = 'NoOffset'

! Baseline mode.   => not currently used
      Base_mode = 'geocenter '
!     Base_mode = 'baseline  '
!     Base_mode = 'master-stn'

!     Atmdr          - 'Add-dry   ' or 'no-Add-dry' atmosphere.
!     Add or not dry atmosphere model
      Atmdr  = 'Add-dry   '
!     Atmdr  = 'no-Add-dry'      

!     Atmwt          - 'Add-wet   ' or 'no-Add-wet' atmosphere.
!     Add or not wet atmosphere model
      Atmwt  = 'Add-wet   '
!     Atmwt  = 'no-Add-wet'

!     L_time  - 'dont-solve' or 'solve' for light travel time from spacecraft. Default is 'dont-solve'. 
      L_time = 'dont-solve'
!     L_time = 'solve     '

      NF_model = 'Duev    '
! Modified Sekido near-field model
!     NF_model = 'Sekido  '
! Satellite ranging near-field model.      
!     NF_model = 'Ranging '
! Duev near-field model. (default)      
!     NF_model = 'Duev    '

! Station positions - not sure what default does      
      DoStnPos = 0
! Write station J2000 positions. 
!     DoStnPos = 1
! Write station ITRF positions
!     DoStnPos = 2

! Type of UVW to calculate
      UVW = 'exact '
!     -uncorr            U,V,W: non-relativistic geometry.
!     UVW = 'uncorr'
!     -approx            U,V,W: n-r geometry with aberration.
!     UVW = 'approx' 
!     -noatmo            U,V,W: exact but no atmosphere.
!     UVW = 'noatmo'


!      Interval between Calc runs (default is every 24 seconds 
      d_interval = 24.D0
!      int_poly = 120
!   # of Calc epochs in each 2-minute interval - Should allow this to be set
      epoch2m = (120.0001/d_interval) + 1

!     # of input calc jobs
      Numjobs = 0

! Spacefraft handling stuff - removed from this version. Check d_Input from DIFXCalc11
!      t_offset = 0
!     SpOffset = 'Offset  '

!     Initialize all flow control and debug output flags to zero.
      DO N = 1, NFLAG
        IFLAG(N) = 0
      end do
       

      JobId = 1
      NumSit = 0
      NumSpace = 0
      NUMSTR = 1
      NumSrc = 1
      SpFrame = 'ECJ2'
      NumScans = 1
      Do IK=1, Max_Stat
        SITAXO(IK) = 0.D0
        Do KJ=1,3
          SITXYZ(KJ,IK) = 0.D0
        Enddo
      Enddo

! Number of EOPs loaded
      WOBIF(3) = 0 

!   Get the apriori's from the .calc file.
      call dGet_input()

!
! Set Geocenter station;
      Zero_site = 1
      SITES(1) = 'GEOCENTR'
      Axis(1)  = 'AZEL'
      SITAXO(1) = 0.D0
      SITXYZ(1,1) = 0.D0
      SITXYZ(2,1) = 0.D0
      SITXYZ(3,1) = 0.D0
      NUMSIT = 1

!     Normal conclusion.
      RETURN
!
      END
!
!**********************************************************************
      BLOCK DATA dSTACMB
      IMPLICIT None
!
! 1.     STABD
!
! 1.1.1  STABD IS THE BLOCK DATA INITIALIZATION SECTION FOR THE START MODULE.
!        IT HOLDS THE LOAD MODULE DATE MESSAGE.
!
! 1.2.2  COMMON BLOCKS USED
      Real*8  XCALC
      Integer*2 NFLAG,NFLAGC,loadm(8),LFILE(3)
      COMMON /STACM/ Computing_center,XCALC,NFLAG,NFLAGC,loadm,LFILE
      Character*64 Computing_center
      CHARACTER*16 LOADM_CHR
      EQUIVALENCE (LOADM,LOADM_CHR)
      CHARACTER*6 C_LFILE
      EQUIVALENCE (C_LFILE,LFILE)
!
!       VARIABLES 'TO':
!         1. LOADM - THE LOAD MODULE COMPILATION DATE MESSAGE.
!         2. NFLAG - THE TOTAL NUMBER OF CALC FLOW CONTROL AND DEBUG FLAGS.
!         3. LFILE(3) - THE NAME OF THE CALC CONTROL FILE.
!         4. XCALC - THE CALC PROGRAM VERSION NUMBER.
!
!     DATA LOADM_CHR /'Ver. 2011.07.19 '/
      DATA NFLAG /62/
!     DATA C_LFILE /'CALCON'/
!     DATA XCALC/10.99D0/
!
! 1.2.9  PROGRAMMER - BRUCE SCHUPLER 05/12/78
!                     BRUCE SCHUPLER 06/05/78
!                     BRUCE SCHUPLER 09/14/78
!                     BRUCE SCHUPLER 12/06/78
!                     BRUCE SCHUPLER 06/06/79
!                     BRUCE SCHUPLER 08/26/80
!                     DAVID GORDON   06/19/84
!                     DAVID GORDON   01/08/85 (REMOVED IDISC=59)
!                     SAVITA GOEL    06/02/87 (CDS FOR A900)
!                     Jim Ryan 89.07.25 Documentation simplified.
!                     Jim Ryan 89.12.12 UNIX-like database interface
!                                    implimented.
!                     David Gordon 94.04.15 Converted to Implicit None
!                     David Gordon 98.07.23 Removed ISECU, IDISC, and IOPEN
!                                    from Common /STACM/.
      END
!**********************************************************************
      REAL*8 FUNCTION JDY2K (IYEAR, IMONTH, IDAY)
      Implicit None
!
!     Function JDY2K: Function to convert year, month, day to full Julian
!     day. The year can be either a four-digit year or a two-digit year.
!
!     If a 4-digit year, this function is good from 1 March 1900 to 31
!     December 2099.
!
!     If a 2-digit year, this function is good from 1 January 1970 to
!     31 December 2069. If year is 70 - 99, 1900 is added. If year is
!     00 - 69, 2000 is added.
!
!     Programmer:
!      98.07.23  D. Gordon  Function written from code in cutcu.f
!
      Integer*4 IYEAR, IMONTH, IDAY, IY, IM, ID
!
       IY = IYEAR
       IM = IMONTH
       ID = IDAY
!
       If (IY .ge. 70 .and. IY .le. 99) Then
        IY = IY + 1900
        Go To 100
       Endif
!
       If (IY .ge. 0 .and. IY .le. 69) Then
        IY = IY + 2000
        Go To 100
       Endif
!
       If (IY .gt.1900 .and. IY .le. 2099) Then
        Go To 100
       Endif
!
!     Year out of range if we get here
       Print *, ' JDY2K, Year out of Range, Stopping! ', IY
       Stop
!
 100   Continue
!
        JDY2K = 367.D0*IY - (7 * ( IY + (IM+9)/12) )/4 + &
     &          (275*IM)/9 + ID + 1721013.5D0
!
!      Write(6,1000) IYEAR, IMONTH, IDAY, IY, IM, ID, JDY2k
 1000  Format(/,'Function JDY2K: ',/,' Input, Modified Y,M,D: ', &
     &        2x,3I5,5x,3I5,/,' JDY2K ', F15.2)
      Return
      End
!
!**********************************************************************
      SUBROUTINE dGet_input()
      IMPLICIT None
!
!
! 3.2.2 COMMON BLOCKS USED -
!
!!!!  INCLUDE 'cuser11.i'
!       Variables from:
!         1. Calc_user  - Calc user type. 'A' for Calc/SOLVE analysis.
!                         'C' for VLBI correlator.
!      INCLUDE 'cmxut11.i'
!            Variables 'to':
!              1. Xintv(2)  - First and last Julian Date in the data base
!              1. UT1IF(4)  - The final UT1 information array. This array
!                             contains respectively: 1) The Julian date of the
!                             first tabular point, 2) The increment in days of
!                             the tabular points, 3) The number of tabular
!                             points, 4) The units of the UT1 tabular array per
!                             second. (days, days, unitless, sec/table unit)
!              2. UT1PT(20) - The tabular values of 'TAI minus UT1'.
!                             (table units)
!              3. ISHRTFL   - The short period tidal terms flag, (unitless).
!                             = 1 --> UT1 table coming from input database is
!                             true UT1, (that is, fortnightly tidal terms have
!                             not been removed, as in the IRIS or IERS series).
!                             = -1 --> UT1 table coming from input database is
!                             UT1R, (that is, the Yoder fortnightly tidal terms
!                             HAVE been removed as in Bulletin B).
!                             = -2 --> UT1 table coming from input database is
!                             UT1S, (the S tidal terms HAVE been removed).
!              4. Leap_fix   - Used in external input mode. .True. means
!                              correct the input EOP series for accumluated
!                              leap seconds. .False. means do not correct.
!              5. UT1type    - UT1 data type: 'UT1-TAI ' or 'UT1-UTC '.
!                              For ''UT1-UTC ', leap second corrections
!                              must be made.
!              6. EOP_time_scale - EOP table time scale, allowed values:
!                              'TAI     ', 'TCG     ', 'TDB     ',
!                              'TDT     ', 'UTC     ', 'UNDEF   '.
!                              Assumed default if not present => TDB
!
      INCLUDE 'cmwob11.i'
!            Variables 'to':
!              1. WOBIF(3)  -  The wobble information array. Contains
!                              respectively: 1) The Julian date of the first
!                              tabular point, 2) The increment in days of the
!                              tabular points, 3) The number of tabular points.
!                              (days, days, unitless)
!              2. XYWOB(2,20)- The wobble tabular points for the polar motion
!                              (wobble) X & Y offsets. (milliarcsec)
!                              (Note: Based on old BIH conventions, offsets
!                              are assumed to be left-handed.)
!
      INCLUDE 'cmxst11.i'
!      Variables from:
!       1. Max_Stat             -  Maximum number of stations that can be 
!                                  processed.
!      Variables to:
!*      1. CFRAD(Max_Stat)      -  THE SITE SPHERICAL EARTH RADII.  (M)
!*      2. PLAT(3,Max_Stat)     -  THE PARTIAL DERIVATIVES OF THE SITE CRUST
!*                                 FIXED VECTOR COMPONENTS WITH RESPECT TO THE
!*                                 GEODETIC LATITUDES. (M/RAD)
!*      3. PLON(3,Max_Stat)     -  THE PARTIAL DERIVATIVES OF THE SITE CRUST
!*                                 FIXED VECTOR COMPONENTS WITH RESPECT TO THE
!*                                 EAST LONGITUDES. (M/RAD)
!       4. SITAXO(Max_Stat)     -  THE SITE ANTENNA AXIS OFFSETS. (M)
!       5. SITOAM(11,Max_Stat)  -  THE SITE VERTICAL OCEAN LOADING AMPLITUDES.
!                                  (M)
!       6. SITOPH(11,Max_Stat)  -  THE SITE VERTICAL OCEAN LOADING PHASES.
!                                  (RAD)
!       7. SITXYZ(3,Max_Stat)   -  THE SITE CRUST FIXED X, Y, & Z
!                                  COORDINATES. (M, M, M )
!*      8. SNRM(3,Max_Stat)     -  THE X, Y, AND Z COMPONENTS OF THE SITE
!*                                 NORMAL UNIT VECTORS. (UNITLESS)
!*      9. SITZEN(Max_Stat)     -  THE ZENITH ELECTRICAL PATH LENGTH AT EACH
!*                                 OBSERVATION SITE. (SEC)
!*     10. TCROT(3,3,Max_Stat)  -  THE ROTATION MATRICES WHICH ROTATE THE
!*                                 TOPOCENTRIC REFERENCE SYSTEM TO THE CRUST
!*                                 FIXED REFERENCE SYSTEM FOR EACH SITE.
!*                                 (UNITLESS)
!*     11. XLAT(Max_Stat)       -  THE SITE GEODETIC LATITUDES. (RAD)
!*     12. XLON(Max_Stat)       -  THE SITE EAST LONGITUDES. (RAD)
!      13. KTYPE(Max_Stat)      -  THE SITE ANTENNA AXIS TYPES. (UNITLESS)
!*     14. NLAST(2)             -  THE INTEGER VARIABLE WHICH DETERMINES IF
!*                                 THE BASELINE ID HAS CHANGED FROM ONE
!*                                 OBSERVATION TO THE NEXT.
!*                                 (NOTE: THE SITE GEOMETRY NEED NOT BE
!*                                 RELOADED FOR EACH OBSERVATION IF THE
!*                                 BASELINE ID DOES NOT CHANGE. NLAST MUST BE
!*                                 INITIALIZED TO ZERO IN THE INITIALIZATION
!*                                 SECTION AND PASSED TO THE GEOMETRY SECTION
!*                                 SO THAT IT WILL HAVE ZERO VALUES UNTIL
!*                                 AFTER THE FIRST OBSERVATION IS PROCESSED.)
!*     15. NUMSIT               -  THE NUMBER OF SITES IN THE SITE CATALOG.
!      16. LNSITE(4,Max_Stat)   -  THE EIGHT CHARACTER SITE NAMES OF THE
!                                  SITES IN THE SITE CATALOG. (ALPHAMERIC)
!      17. SITHOA(11,2,Max_Stat) - THE SITE HORIZONTAL OCEAN LOADING
!                                  AMPLITUDES. (M)
!      18. SITHOP(11,2,Max_Stat) - THE SITE HORIZONTAL OCEAN LOADING PHASES.
!                                  (RAD)
!*     19. HEIGHT(Max_Stat)     -  Height above the geoid. (meters)
!*     20. RTROT(3,3,Max_Stat)  -  The rotation matrices which rotate the
!*                                 'radial-transverse' reference system to the
!*                                 crust fixed reference system for each site.
!*                                 (Unitless). The 'radial-transverse' ref.
!*                                 system is nearly identical to the
!*                                 topocentric system. 'Up' is in the radial
!*                                 direction from the center of the Earth;
!*                                 'East' is East; and 'North' is perpendicular
!*                                 to the radial in the north direction.
!*     21. GLAT(Max_Stat)       -  The geocentric latitude at each site. (rad)
!      22. Zero_site            -  The site number of the site at the
!                                  geocenter, if there is one in this data
!                                  set. For correlator usage.
!      23. Dbtilt(Max_Stat,2)   -  Antenna fixed axis tilts, in arc-minutes.
!                                  For alt-az mounts, 1 => East tilt,
!                                  2 => North tilt.
!*     24. Rotilt(3,3,Max_Stat) -  Rotation matrices representing the antenna
!*                                 fixed axis tilts, in the local topocentric
!*                                 station frame. X = Up, Y = East, Z = North.
!      25. OPTL6(6,Max_stat)    -  The site ocean pole tide loading 
!                                  coefficients, interpolated from the Desai
!                                  lat/lon table.
!
!      INCLUDE 'cmxsr11.i'
!       VARIABLES 'TO':
!         1. LNSTAR(10,MAX_ARC_SRC)- THE ALPHANUMERIC CHARACTER NAMES
!                                    OF THE STARS IN THE STAR CATALOG.
!                                    Now up to 20 characters in difx mode.
!         2. NUMSTR                - THE NUMBER OF STARS IN THE STAR
!                                    CATALOG.
!         3. RADEC(2,MAX_ARC_SRC)  - THE RIGHT ASCENSIONS AND DECLINATIONS
!                                    OF THE STARS IN THE STAR CATALOG.
!                                    (RAD, RAD)
!         4. P_motion(3,Max_arc_src)-The RA and Dec proper motions and
!                                    appropriate epoch for stars in the
!                                    star catalog. (arc-sec/yr, arc-sec/yr,
!                                    year (i.e. 1995.5, etc.))
!         5. D_psec(Max_arc_src)   - Distances, if known, for stars in the
!                                    star catalog. Zero => unknown.
!                                    (parsecs)
!         6. PRcorr(2,Max_arc_src) - Proper motion corrections in RA and
!                                    Declination for each star. (Radians)
!
!

!      INCLUDE 'd_input.i'
!      Character*20 SrcName(MAX_ARC_SRC)
!      Equivalence (LNSTAR(1,1), SrcName(1))

!      call set_times(60255.68715277778d0, 60255.6875d0)

!      call load_source(1, '1934-638', 5.1d0, -1.0d0)

!     Number of  EOPs
!      WOBIF(3) = 0 
!      call load_eop(60252, 37, 0.2672, 0.2618,  0.01248)
!      call load_eop(60253, 37, 0.2654, 0.2600,  0.01287)
!      call load_eop(60254, 37, 0.2636, 0.2583,  0.01312)
!      call load_eop(60255, 37, 0.2618, 0.2567,  0.01318)
!      call load_eop(60256, 37, 0.2599, 0.2550,  0.01304)
!      call load_eop(60257, 37, 0.2581, 0.2534,  0.01272)
      
      Return
      End

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      SUBROUTINE FixEpoch(JTAG, TAG_SEC)
      IMPLICIT None
!
      Real*8    TAG_SEC
      Integer*4 JTAG(5), Imin
      Integer IMNTHS(12)
      DATA IMNTHS /31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31/
!
!      Write (6,*) 'FixEpoch: ', JTAG, TAG_SEC
!
! Check for leap year
      IF(MOD(JTAG(1),4) .EQ. 0) IMNTHS(2) = 29
!
      IF (TAG_SEC .ge. 59.9999999) Then  ! Increment minutes
       Imin = TAG_SEC/60.D0 + .00001
       TAG_SEC = TAG_SEC - Imin*60.0D0
       JTAG(5) = JTAG(5) + Imin  ! minutes
        If (JTAG(5) .ge. 60) Then     ! Increment hours
         JTAG(5) = JTAG(5) - 60
         JTAG(4) = JTAG(4) + 1  ! hours
          If (JTAG(4) .ge. 24) Then     ! Increment days
           JTAG(4) = JTAG(4) - 24
           JTAG(3) = JTAG(3) + 1   ! days
            If (JTAG(3) .gt. IMNTHS(JTAG(2))) Then ! Increment month
             JTAG(3) = JTAG(3) - IMNTHS(JTAG(2))    ! days, should be 1
             JTAG(2) = JTAG(2) + 1   ! month
             If (JTAG(2) .gt. 12) Then               ! Increment year
              JTAG(2) = 1
              JTAG(1) = JTAG(1) + 1
             Else
              Return
             Endif                                   ! Increment year
            Else
             Return
            Endif                                  ! Increment month
          Else
           Return
          Endif                         ! Increment days
        Else
         Return
        Endif                         ! Increment hours
      ENDIF                              ! Increment minutes
!      Write (6,*) 'FixEpoch: ', JTAG, TAG_SEC
!
      Return
      End
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      SUBROUTINE FixEpoch2(JTAG, TAG_SEC)
      IMPLICIT None
!
      Real*8    TAG_SEC, Xmin, Xhr
      Integer*4 JTAG(5), Imin, Ihr
      Integer IMNTHS(12)
      DATA IMNTHS /31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31/
!
!      Write (6,*) 'FixEpoch2/Before: ', JTAG, TAG_SEC
!
! Check for leap year
      IF(MOD(JTAG(1),4) .EQ. 0) IMNTHS(2) = 29
!
      IF (TAG_SEC .ge. 59.9999999) Then  ! Reset seconds and increment minutes
       Xmin = TAG_SEC/60.D0 + .00001
       Imin = Xmin
       TAG_SEC = TAG_SEC - Imin*60.0D0
       JTAG(5) = JTAG(5) + Imin  ! minutes
      ENDIF
!
       If (JTAG(5) .ge. 60) Then     ! Reset minutes ana increment hours
        Xmin = JTAG(5)
        Xhr  = Xmin/60.D0
        Ihr  = Xhr
        JTAG(5) = JTAG(5) - Ihr * 60  ! minutes
        JTAG(4) = JTAG(4) + Ihr 
       Endif
!
          If (JTAG(4) .ge. 24) Then     ! Reset hours and increment days
           JTAG(4) = JTAG(4) - 24
           JTAG(3) = JTAG(3) + 1   ! days
            If (JTAG(3) .gt. IMNTHS(JTAG(2))) Then ! Increment month
             JTAG(3) = JTAG(3) - IMNTHS(JTAG(2))    ! days, should be 1
             JTAG(2) = JTAG(2) + 1   ! month
             If (JTAG(2) .gt. 12) Then               ! Increment year
              JTAG(2) = 1
              JTAG(1) = JTAG(1) + 1
             Else
              Return
             Endif                                   ! Increment year
            Else
             Return
            Endif                                  ! Increment month
          Else
           Return
          Endif                         ! Increment days
!
!      Write (6,*) 'FixEpoch2/After:  ', JTAG, TAG_SEC
!
      Return
      End
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
      SUBROUTINE USAGE()
      IMPLICIT None
!
      Write(6,1001)
 1001 Format(/,' Program difxcalc: Calc 11 for the difx correlator.',/, &
     &  ' Send comments, suggestions, requests, etc to',                &
     &  ' David.Gordon-1@nasa.gov.  ',/ ,                               &
     &  ' ************** 2016 July 07 Version *************     ',//,   &
     &  ' Usage: difxcalc [options] <file1>  ',/,                       &
     &  ' or:    difxcalc [options] <file1> <file2> <file3> ... ',/,    &
     &  ' or:    difxcalc [options]  --all                      ',/,    &
     &  ' or:    difxcalc [options]  all                      ',/,      &
!    &  ' or:    difxcalc [options]  *                      ',//,       &
     &  ' <file1> <file2>, etc. should be .calc files.      ',//,       &
!    &  ' "*", "all" or "--all" processes all .calc files in the working',   &
     &  ' all or --all processes all .calc files in the working',       &
     &  ' directory (2000 max).                                 ',//,   &
     &  ' If the .calc file contains a spacecraft ephemeris, then',     &
     &  ' difxcalc will',/,'  switch to the near-field model.',//,      &
!    &  '  Uses the Sekido and Fukushima (2006) model for near-',       &
!    &  'field delays.  ',//,                                           &
     &  ' Options can include: ',/,                                     &
     &  '  --help ',/                                                   &
     &  '  -h                 Print this help and quit.    ',//,        &
!    &  '  --verbose ',/,                                               &
     &  '  -v                 Verbose: Small printout.          ',//,   &
!    &  '  -v 1               Verbose: Small printout.          ',//,   &
!    &  '  -v 2               Verbose: More printout.           ',/,    &
!    &  '  -v 3               Verbose: Much more printout.     ',//,    &
!    &  '  --quiet ',/,                                                 &
!    &  '  -q                 Be less verbose in operation.    ',//,    &
     &  '  -s                 Write station J2000 positions.    ',//,   &
     &  '  -n                 Write station ITRF positions.    ',//,   &
     &  '  -dry               DO NOT ADD dry atm delays.      '/,       &
     &  '                     (Default is to ADD dry atm.)     ',//,    &
     &  '  -wet               DO NOT ADD wet atm delays.      '/,       &
     &  '                     (Default is to ADD wet atm.)     ',//,    &
!    &  '  -b                 Baseline mode. Do ALL baselines.  ',/,    &
!    &  '                     (Default is geocenter mode.)     ',//,    &
!    &  '  -m                 Master station mode. First       ',/,     &
!    &  '                     antenna to all others.           ',//,    &
!    &  '  -e <n>             Epoch interval. Default: 24 seconds. ',/, &
!    &  '                     Permitted values of n (seconds): ',/,     &
!    &  '                     1,2,3,4,5,6,8,10,12,15,20,24,30,60. ',//, &
!    &  '  -im                Turn OFF the .im file output.     ',/,    &
!    &  '                     (Default is to write a .im file.) ',//,   &
!    &  '  -o                 Write calc output to a           ',/,     &
!    &  '                     *.calc.out file.            ',//,         &
     &  '  -f                 Force execution, overwrite existing .im files.',//, &
     &  '  -uncorr            U,V,W: non-relativistic geometry.',//,    &
     &  '  -approx            U,V,W: n-r geometry with aberration.',//,  &
     &  '  -exact             U,V,W: partial derivatives (default).',//, &
     &  '  -noatmo            U,V,W: exact but no atmosphere.      ',//, &
     &  '  -S                 Use modified Sekido near-field model.',/, &
!    &  '  --Sekido           Use modified Sekido near-field model.',/, &
     &  '  -D                 Use Duev near-field model. (default)',/,  &
!    &  '  --Duev             Use Duev near-field model. (default)',/, &
     &  '  -R                 Use satellite ranging near-field model.',//, &
!    &  '  --Ranging          Use satellite ranging near-field model.',//, &
     &  '  -lt                Solve for light travel time.    ',/,      &
     &  '                     (Near-field mode only)      ',//,         &
     &  '  -t <offset>        Near-field ephemeris epoch offset.   ',/, &
     &  '                     (in seconds, Real or Integer)       ',//, &
     &  '                                                   ')
!
      Stop
      End
