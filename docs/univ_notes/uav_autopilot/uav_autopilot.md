# Lab1.
## Introduction to Open CV and installation
[Lab1 pdf](Lab1.pdf)

## Install Open CV
* In the Ubuntu 16.04 64bit
Required dependencies are the followings <br />
1. Git
2. Python 2.6 or later and Numpy 1.5 or later with developer packages (python-dev, python-numpy)
3. CMake 2.6 or higher
4. GCC 4.4.x or later

```
sudo apt-get install libopencv-dev python-opencv
```

Once installed
```
pkg-config --modversion opencv
```
If the version is shown, then we're good to rock with opencv.
* Build your opencv_file.cpp with CMake or g++ standards
1.With CMake (Don't forget to add CMakeLists.txt)

```make
cmake_minimum_required(VERSION 2.8)
project( <project_name> )
find_package( OpenCV REQUIRED )
add_executable( <project_name> <project_name>.cpp )
target_link_libraries( <project_name> ${OpenCV_LIBS} )
```

2. With g++ and flags for opencv libraries
```
g++ lab1-2.cpp `pkg-config --cflags --libs opencv`
```
## Today's algorithm
[Bilinear Interpolation](https://en.wikipedia.org/wiki/Bilinear_interpolation)
Basically ,this is an algorithm aimed for image transformation in this lab. <br />
The interpolated value of a point is a reversely-weighted average of the neighboring points, <br />
such method is quite useful in the image transformation.
