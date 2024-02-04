AM_FFLAGS = -g -I$(top_srcdir)/src  -ffree-form

FCFLAGS = -g -I$(top_srcdir)/src

LDADD = \
        $(top_builddir)/src/libcalc11.la

bin_PROGRAMS = \
        testCalc11 \
	test

testCalc11_SOURCES = \
        testCalc11.f90

test_SOURCES = \
	test.f90 subA.f subB.f

