cmake_minimum_required (VERSION 3.5)
project (CALC11LIB_TESTS LANGUAGES Fortran C)

set(CMAKE_BUILD_TYPE Debug)

add_executable(testCalc11 testCalc11.f90)
target_link_libraries(testCalc11 PUBLIC calc11_lib)

add_executable(testCalc11_c testCalc11_c.c)
target_link_libraries(testCalc11_c PUBLIC calc11_lib)

add_executable(testCalc11_c2 testCalc11_c2.c)
target_link_libraries(testCalc11_c2 PUBLIC calc11_lib)

