cmake_minimum_required (VERSION 3.5)
project (CALC11LIB LANGUAGES Fortran C)

find_package(GSL REQUIRED)

set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_Fortran_FLAGS "-g -O2 -ffree-form")

# Alter some of the input files.
include (TestBigEndian)
TEST_BIG_ENDIAN(IS_BIG_ENDIAN)
if(IS_BIG_ENDIAN)
  set(de421_file "DE421_big_Endian")
else()
  set(de421_file "DE421_little_Endian")
endif()
set(prefix ${CMAKE_INSTALL_PREFIX})
configure_file(src/param11.i.in param11.i @ONLY)

# Set the installation directory for the necessary calc files.
install(FILES data/${de421_file} data/tilt.dat data/ocean_load.coef data/ocean_pole_tide.coef data/ut1ls.dat DESTINATION share/calc11)

# The calc11 library and C wrappers.
set(calc11_dir src)
FILE(GLOB calc11lib_files ${calc11_dir}/*.f ${calc11_dir}/*.c ${calc11_dir}/*.f90)
add_library(calc11_lib STATIC ${calc11lib_files})
target_include_directories(calc11_lib PUBLIC ${CMAKE_CURRENT_BINARY_DIR} ${calc11_dir})
target_link_libraries(calc11_lib PUBLIC ${GSL_LIBRARY})

# The test executables.
if (CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
  add_subdirectory(tests)
endif()
