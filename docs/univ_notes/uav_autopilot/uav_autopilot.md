# UAV Drone autopilot, computer vision and image processing.
Spring 2018<br />
Lecturer: [K.W. Chen](https://www.cs.nctu.edu.tw/cswebsite/members/detail/kuanwen) in CS@NCTU <br />
Time: 4IJK @EC330_NCTU<br />

## Lab1. Introduction to Open CV and installation Mar 01, 2018
[Lab1 pdf](Lab1.pdf)
### Install Open CV
* In the Ubuntu 16.04 64bit
Required dependencies are the followings <br />
1.Git <br />
2.Python 2.6 or later and Numpy 1.5 or later with developer packages (python-dev, python-numpy) <br />
3.CMake 2.6 or higher <br />
4.GCC 4.4.x or later <br />

```
sudo apt-get install libopencv-dev python-opencv
```
Once installed
```
pkg-config --modversion opencv
```
If the version is shown, then we're good to rock with opencv. <br />

* Build your opencv_file.cpp with CMake or g++ standards

1.With CMake (Don't forget to add CMakeLists.txt)

```make
cmake_minimum_required(VERSION 2.8)
project( <project_name> )
find_package( OpenCV REQUIRED )
add_executable( <project_name> <project_name>.cpp )
target_link_libraries( <project_name> ${OpenCV_LIBS} )
```

2.With g++ and flags for opencv libraries
```
g++ lab1-2.cpp `pkg-config --cflags --libs opencv`
```
### Today's course contents
Basic understanding of image processing and image data format.
[Course week1 pdf](DIP_1.pdf)

[Bilinear Interpolation](https://en.wikipedia.org/wiki/Bilinear_interpolation)
Basically ,this is an algorithm aimed for image transformation in this lab. <br />
The interpolated value of a point is a reversely-weighted average of the neighboring points, <br />
such method is quite useful in the image transformation.
