# libCalc11 

Port of difxCalc11 to create a library version, while retaining all functionality


## Building

This code builds in the normal autoconf way:
```
make
```

It can also be built with CMake (which is better). The library requires the files
in the data directory to be installed in a location specified in a Fortran header
file. CMake can install these in the proper place, but you will need to specify
the desired prefix for the location.

By default, CMake will attempt to install in the directory `/usr/local`, and will
put the data files in the path `share/calc11` under that directory. You can change
this with the `-DCMAKE_INSTALL_PREFIX:PATH` directive when running `cmake`.

You can also specify your preferred Fortran compiler with the
`-DCMAKE_Fortran_COMPILER` directive.

For example, to use `gfortran` as the compiler and to install in your home
directory, you could use the commands:
```
mkdir build
cd build
cmake -DCMAKE_Fortran_COMPILER=gfortran -DCMAKE_INSTALL_PREFIX:PATH=${HOME} ..
make
make install
```



## 

Run the test progam test/testCalc11. Currently uses hard coded values



