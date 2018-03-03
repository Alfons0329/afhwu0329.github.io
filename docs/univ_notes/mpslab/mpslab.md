# Microprocessor Lab
Fall 2017<br />
Lecturer: [S.L. Tsao](https://www.cs.nctu.edu.tw/cswebsite/members/detail/sltsao) in CS@NCTU <br />
Time: 5EF @EDB27_NCTU 3IJK @EC222_NCTU<br />

## Microprocessor Lab Final Project

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


### About my final project

* Project name: The RGB Ambient light. <br />
* Features: <br />
1.Fully-customizable RGB proportion control. <br />
2.Color cycle speed controller (faster->original)<br />
3.Light-sensitive resistor ADC ,detecting the background light for light quantity settings<br />
[GitHub repo for this final project](https://github.com/Alfons0329/MPSLab_Fall_2017/tree/master/Final_Project)
[Project demo video](https://www.youtube.com/watch?v=FdnTKmdjxIc)
### Part0. Origin of this idea and preparation
* Origin of this idea
I once have the fully-customizable dynamic RGB LED backlit keyboard [SteelSeries APEXM 650](https://steelseries.com/gaming-keyboards/apex-m650) <br /> On account of having not much time in the end of semester(machine learning final project + compiler design final project.)
My [teammate](https://github.com/clialice123) and I decided to do it.

* Preparation of materials and tools for this project
1.A STM32L476RG Embedded board<br />
2.Breadboard<br />
3.4pin RGB LED*5 [Click here](https://www.ebay.com/p/5pcs-5mm-4pin-Common-Anode-Diffused-RGB-Tri-color-Red-Green-Blue-LED-Diodes-US/582514711?iid=192112725234)<br />
4.R1000 Resistor<br />
5.Some Dupont cables<br />

### Part1. Circuit connection
1.Parallel connection of 5 RGB LEDs on the breadboard.<br />
2.Connect separately to the GPIO pin on the STM32 providing the capability of PWM output.<br />
3.Connect the keypad to the STM32.<br />
4.Connect the light-sensitive resistor to GPIO with capability of ADC(Analog-Digital Converter).<br />
5.The GPIO Connection is like.<br />
6.Overall GPIO port configuration.<br />

```c
GPIOB->ASCR |= 0b1; //turn on the analog controller in PB0

void keypad_init()//keypad along with GPIO Init together
{

	RCC->AHB2ENR   |= 0b00000000000000000000000000000111; //open port A,B,C
				      //10987654321098765432109876543210
	GPIOC->MODER   &= 0b11111111111111111111111100000000; //pc 3 2 1 0 as input of keypad
	GPIOC->MODER   |= 0b00000000000000000000000001010101;
	GPIOC->PUPDR   &= 0b11111111111111111111111100000000;
	GPIOC->PUPDR   |= 0b00000000000000000000000001010101;
	GPIOC->OSPEEDR &= 0b11111111111111111111111100000000;
	GPIOC->OSPEEDR |= 0b00000000000000000000000001010101;
	GPIOC->ODR     |= 0b00000000000000000000000000001111;
	                  //10987654321098765432109876543210
	GPIOB->MODER   &= 0b11111111111111110000000011111111; //pb 7 6 5 4 as output of keypad
	GPIOB->PUPDR   &= 0b11111111111111110000000011111111;
	GPIOB->PUPDR   |= 0b00000000000000001010101000000000;


}

void GPIO_init_AF() //GPIO Alternate Function Init
{
	/***************pin and alternate function***************
	 * PB3 + AF1 which is corresponding to TIM2_CH2 RED
	 * PA1 + AF2 which is corresponding to TIM5_CH2 GREEN
	 * PA6 + AF2 which is corresponding to TIM3_CH1 BLUE
	 ********************************************************/
					   //10987654321098765432109876543210
	GPIOA->MODER   	&= 0b11111111111111111100111111110011;
	GPIOA->MODER   	|= 0b00000000000000000010000000001000;
	//PortA Pin		   //10987654321098765432109876543210
	GPIOA->AFR[0]	=  0b00000010000100000000000000100000;

	//PB3 TIM2_CH2
	GPIOB->AFR[0] 	&= ~GPIO_AFRL_AFSEL3;//AFR[0] LOW
	GPIOB->AFR[0] 	|= (0b0001<<GPIO_AFRL_AFSEL3_Pos);//PB3 Alternate function mode
}

```

### Part2. Key idea of this project

The PWM(Pulse Width Modulation) [Wiki](https://en.wikipedia.org/wiki/Pulse-width_modulation)
PWM cycle (HV/ALL) = The proportion where light lights, the longer HV lasts, the brighter of the certain part of RGB(either one) will do.<br />
The Pulse Width can be used to simulate the analog output like this.<br />
![PWM Video](final_project_pics/PWM.MOV)<br />
The same is true of other 3 colors, configuring with the following code and expanations.<br />
* Basic logic for this project <br />
Initialize system -> PWM and timer configuration -> Presskey -> Color changing scheme along with ADC light intensity detection for power saving.
```c
int keypad_value[4][4] = {{0,1,2,3},
						  {4,5,6,7},
						  {8,9,10,11},
						  {12,13,14,15}};
```
keypad explanation <br />
0 red+<br />
1 green+<br />
2 blue+<br />
3 cycle_speed+<br />
4 red-<br />
5 green-<br />
6 blue-<br />
7 customize mode(0 1 2 4 5 6 applicable)<br />
8 only red<br />
9 only green<br />
10 only blue<br />
11 light ADC mode<br />
12 red+greren<br />
13 green+blue<br />
14 red+blue<br />
15 off system, remember the last state, s.t. user configuration is not lost after shut down<br />
* Setup the PWM channel<br />
Refer to [this pdf](https://github.com/Alfons0329/MPSLab_Fall_2017/blob/master/STM32%20Datasheet.pdf) for PWM channel-GPIO port configuration, each port has its corresponding PWM channel and built-in system clock, be sure to make it right! <br />

More understanding and details are written in comments of the following source code.<br />
Please refer to **p.1006-1039**[this pdf](https://github.com/Alfons0329/MPSLab_Fall_2017/blob/master/Cortex%20M4%20STM32%20Manual.pdf) to see how to config the PWM cycle with certain registers in timer.
```c
void Timer_init() //Use 3
{
	// PA3 + AF1 which is corresponding to TIM2_CH1
	// PA1 + AF2 which is corresponding to TIM5_CH2
	// PA6 + AF2 which is corresponding to TIM3_CH1
	RCC->APB1ENR1 |= RCC_APB1ENR1_TIM2EN;
	RCC->APB1ENR1 |= RCC_APB1ENR1_TIM3EN;
	RCC->APB1ENR1 |= RCC_APB1ENR1_TIM5EN;

	//setting for timer 2
	TIM2->CR1 &= 0x0000; //p1027 Turned on the counter as the count up mode
	TIM2->ARR = (uint32_t)SECOND_SLICE;//Reload value
	TIM2->PSC = (uint32_t)COUNT_UP;//Prescaler
	TIM2->EGR = TIM_EGR_UG; 	//update the counter again p1035

	//setting for timer 3
	TIM3->CR1 &= 0x0000; //p1027 Turned on the counter as the count up mode
	TIM3->ARR = (uint32_t)SECOND_SLICE;//Reload value
	TIM3->PSC = (uint32_t)COUNT_UP;//Prescaler
	TIM3->EGR = TIM_EGR_UG;//Reinitialize the counter

	//setting for timer 5
	TIM5->CR1 &= 0x0000; //p1027 Turned on the counter as the count up mode
	TIM5->ARR = (uint32_t)SECOND_SLICE;//Reload value
	TIM5->PSC = (uint32_t)COUNT_UP;//Prescaler
	TIM5->EGR = TIM_EGR_UG;//Reinitialize the counter
}


void PWM_channel_init()
{
	/***********************setting for the TIM2_CH2 RED**************************/
	// PB3 + AF1 which is corresponding to TIM2_CH2 RED
	//Output compare 2 mode
	TIM2->CCMR1 &= ~TIM_CCMR1_OC2M;
	//110: PWM mode 1: TIMx_CNT<TIMx_CCR2-->active, or inactive
	TIM2->CCMR1 |= (0b0110 << TIM_CCMR1_OC2M_Pos);

	//Output Compare 2 Preload Enable
	TIM2->CCMR1 &= ~TIM_CCMR1_OC2PE;//OCxPE
	//1: enable TIMx_CCR1 Preload
	TIM2->CCMR1 |= (0b1 << TIM_CCMR1_OC2PE_Pos);
	//enable auto reload pre-load
	TIM2->CR1 |= TIM_CR1_ARPE;

	//duty cycle initial 50 (CCR2/ARR)
	//TIM2->CCR2 = duty_cycle_R;
	//enable output compare
	TIM2->CCER |= TIM_CCER_CC2E;

	/***********************setting for the TIM5_CH2 GREEN**************************/
	// PA1 + AF2 which is corresponding to TIM5_CH2 GREEN
	//Output compare 2 mode
	TIM5->CCMR1 &= ~TIM_CCMR1_OC2M;
	//110: PWM mode 1: TIMx_CNT<TIMx_CCR2-->active, or inactive
	TIM5->CCMR1 |= (0b0110 << TIM_CCMR1_OC2M_Pos);

	//Output Compare 2 Preload Enable
	TIM5->CCMR1 &= ~TIM_CCMR1_OC2PE;//OCxPE
	//1: enable TIMx_CCR1 Preload
	TIM5->CCMR1 |= (0b1 << TIM_CCMR1_OC2PE_Pos);
	//enable auto reload pre-load
	TIM5->CR1 |= TIM_CR1_ARPE;

	//duty cycle initial 50 (CCR2/ARR)
	//TIM5->CCR2 = duty_cycle_G;
	//enable output compare
	TIM5->CCER |= TIM_CCER_CC2E;

	/***********************setting for the TIM3_CH1 BLUE**************************/
	// PA6 + AF2 which is corresponding to TIM3_CH1 BLUE
	//Output compare 2 mode
	TIM3->CCMR1 &= ~TIM_CCMR1_OC1M;
	//110: PWM mode 1: TIMx_CNT<TIMx_CCR2-->active, or inactive
	TIM3->CCMR1 |= (0b0110 << TIM_CCMR1_OC1M_Pos);

	//Output Compare 2 Preload Enable
	TIM3->CCMR1 &= ~TIM_CCMR1_OC1PE;//OCxPE
	//1: enable TIMx_CCR1 Preload
	TIM3->CCMR1 |= (0b1 << TIM_CCMR1_OC1PE_Pos);
	//enable auto reload pre-load
	TIM3->CR1 |= TIM_CR1_ARPE;

	//duty cycle initial 50 (CCR2/ARR)
	//TIM3->CCR1 = duty_cycle_B;
	//enable output compare
	TIM3->CCER |= TIM_CCER_CC1E;

}

```
*
### Part3. It's time to change the color.

* Initialize to different duty cycle. <br />
Each color has its own PWM cycle, by setting the PWM cycle differently, we will be able to interleave 3 colors
and mixing them together since there pulse waves have "time shifting (or say phase shifting)" to each other. <br />
```c

#define RED_START 10
#define GREEN_START 91
#define BLUE_START 172

duty_cycle_R = RED_START;
duty_cycle_G = GREEN_START;
duty_cycle_B = BLUE_START;

int main()
{
	//use the time delay mode to make the interleaving and the color changing scheme
	fpu_enable();
	keypad_init();
	GPIO_init_AF();
	Timer_init();
	configureADC();
	startADC();
	duty_cycle_R = RED_START;
	duty_cycle_G = GREEN_START;
	duty_cycle_B = BLUE_START;
	cur_state = CYCLE_MODE;
	while(1)
	{
		PWM_channel_init();
		chromatic_scheme(keypad_scan());
	}
	return 0;
}

```

* Increase, decrease and cycle. <br />

state_color is the state indicating whether to increase the pulse cycle or decrease, with an view to simulating the sin-wave-like phase wave. <br />

```c
void cycle_mode(int delay_time){
	PWM_channel_init();
	if (state_R){
		if (duty_cycle_R > SECOND_SLICE){
			state_R = 0;
		} else {
			duty_cycle_R += 20;
		}
	} else {
		if (duty_cycle_R < 20){
			state_R = 1;
		} else {
			duty_cycle_R -= 20;
		}
	}

	if (state_G){
		if (duty_cycle_G > SECOND_SLICE){
			state_G = 0;
	} else {
		duty_cycle_G += 40;
		}
	} else {
		if (duty_cycle_G < 40){
			state_G = 1;
		} else {
			duty_cycle_G -= 40;
		}
	}

	if (state_B){
		if (duty_cycle_B > SECOND_SLICE){
			state_B = 0;
		} else {
			duty_cycle_B += 50;
		}
	} else {
		if (duty_cycle_B < 50){
			state_B = 1;
		} else {
			duty_cycle_B -= 50;
		}
	}
	set_timer();
	start_timer();
	delay_ms(delay_time);
}
```

* Customizable mode <br />
If it is in the customize mode, we are able to increase the proportion of color, to achieve that, just increase/decrease the duty cycle of that color. DELTA_VALUE is used to adjust the amount of duty cycle applied in PWM mode.

```c
case 4:
{
	if(duty_cycle_R > DELTA_VALUE)
		duty_cycle_R -= DELTA_VALUE; (or add the DELTA_VALUE)
	else
		duty_cycle_R = 0;
	break;
}
```
### Part4. More idea: the ADC of light-sensitive resistor
The Earth is now facing the serve global warming, it is vital for us to construct a power saving model, consequently Alice and I came out the idea of using the
ADC to detect the light intensity.<br />
The stronger the intensity, the dimmer the light to be to saving the energy since this module is aimed for atmosphere night light. <br />

### Part5. Done all.

Really thanks to my teammate [chialice123](https://github.com/chialice123) who helps me alot during the semester and in the final project, and [vava24680](https://github.com/vava24680) for teaching me some concepts of ADC configuration.
