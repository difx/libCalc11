AM_FFLAGS = -g -I$(top_srcdir)/src  -ffree-form

AM_CPPFLAGS = -I$(top_srcdir)/src

FCFLAGS = -g -I$(top_srcdir)/src

LDADD = \
        $(top_builddir)/src/libcalc11.la

bin_PROGRAMS = \
        testCalc11 \
	testCalc11_c

testCalc11_SOURCES = \
        testCalc11.f90

testCalc11_c_SOURCES = \
        testCalc11_c.c

