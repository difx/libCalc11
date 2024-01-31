# Initialization
AC_INIT([calc11], [0.1], [Chris.Phillips@csiro.au])

AM_INIT_AUTOMAKE([foreign])

AM_SANITY_CHECK

AC_C_BIGENDIAN( \
        [de421_file=DE421_big_Endian], \
        [de421_file=DE421_little_Endian] \
)

# Checks for programs
AC_PROG_CC
AC_PROG_F77

# Check for Fortran compiler flags
AC_FC_FREEFORM

LT_INIT
AC_CONFIG_MACRO_DIRS([m4])

AC_SEARCH_LIBS([sqrt], [m])
PKG_CHECK_MODULES(GSL, [gsl])

LIBS="${LIBS} ${GSL_LIBS}"
CFLAGS="${CFLAGS} ${GSL_CFLAGS}"

AC_SUBST(de421_file)

# Checks for header files
AC_CHECK_HEADERS([stdio.h])

# Output files
AC_CONFIG_HEADERS([config.h])

AC_CONFIG_FILES([
        Makefile \
        data/Makefile \
        src/Makefile \
        src/param11.i \
])

# Output messages
AC_OUTPUT
