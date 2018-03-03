# Microprocessor Lab Final Project

* Course Introduction <br />
This course mainly focus on the embedded system understanding, and we use the ARM microarchitecture in this semester.

* Goal of this course <br />
To briefly understand the ARM Assembly, how to write C code in the embedded developing board and make a small project from it by your own.

* Embedded board spec:<br />
1.Nucleo STM32L476RG ARM Microarchitecture <br />
2.Built-in 400MHz CPU (customizable frequency with internal clock settings provided) <br />
3.GPIO Available <br />
[Detailed specs](http://www.st.com/en/microcontrollers/stm32l476rg.html) <br />

* IDE for this course
**Eclipse  AC6 System Workbench for STM32 where JRE7 is required in your system**

1.Download from [Here for Linux version](http://www.ac6-tools.com/downloads/SW4STM32/install_sw4stm32_linux_64bits-v2.2.run)

* Lab project and final project <br />
There are 10 labs in this semester on a weekly basis, the first five focus on basic operation of ARM Assembly, namely the lab assignments are
typically written in the ARM Assembly, while the last five labs are written in C language, but a embedded-like C language.


## About my final project

* Project name: The RGB Ambient light. <br />
* Features: <br />
1.Fully-customizable RGB proportion control. <br />
2.Color cycle speed controller (faster->original)<br />
3.Light-sensitive resistor ADC ,detecting the background light for light quantity settings<br />
[GitHub repo for this final project](https://github.com/Alfons0329/MPSLab_Fall_2017/tree/master/Final_Project)

## Part0. Origin of this idea and preparation
* Origin of this idea
I once have the fully-customizable dynamic RGB LED backlit keyboard [SteelSeries APEXM 650](https://steelseries.com/gaming-keyboards/apex-m650)on account of having not much time in the end of semester(machine learning final project + compiler design final project.)
My [teammate](https://github.com/clialice123) and I decided to do it.

* Preparation of materials and tools for this project
1.A STM32L476RG Embedded board
2.Breadboard
3.4pin RGB LED*5 [Click here](https://www.ebay.com/p/5pcs-5mm-4pin-Common-Anode-Diffused-RGB-Tri-color-Red-Green-Blue-LED-Diodes-US/582514711?iid=192112725234)
4.R1000 Resistor
5.Some jumper lines

## Part1. Circuit connection
1.Parallel connection of 5 RGB LEDs on the breadboard.
2.Connect separately to the GPIO pin on the STM32 providing the capability of PWM output.
3.Connect the keypad to the STM32
4.Connect the light-sensitive resistor to GPIO with capability of ADC(Analog-Digital Converter)
5.The GPIO Connection is like
```

```

## Part2. Key factor of this project

The PWM,
(c code here)

## Part3. It's time to change the color.

## Part4. More idea: the ADC of light-sensitive resistor
