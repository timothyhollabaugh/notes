EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:switches
LIBS:relays
LIBS:motors
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Heater R3
U 1 1 5A218173
P 6900 2550
F 0 "R3" V 6980 2550 50  0000 C CNN
F 1 "Heater" V 6820 2550 50  0000 C CNN
F 2 "" V 6830 2550 50  0001 C CNN
F 3 "" H 6900 2550 50  0001 C CNN
	1    6900 2550
	0    -1   -1   0   
$EndComp
$Comp
L R R2
U 1 1 5A21822C
P 6900 2250
F 0 "R2" V 6980 2250 50  0000 C CNN
F 1 "R" V 6900 2250 50  0000 C CNN
F 2 "" V 6830 2250 50  0001 C CNN
F 3 "" H 6900 2250 50  0001 C CNN
	1    6900 2250
	0    1    1    0   
$EndComp
$Comp
L R R1
U 1 1 5A2182B7
P 6500 2250
F 0 "R1" V 6580 2250 50  0000 C CNN
F 1 "R" V 6500 2250 50  0000 C CNN
F 2 "" V 6430 2250 50  0001 C CNN
F 3 "" H 6500 2250 50  0001 C CNN
	1    6500 2250
	0    1    1    0   
$EndComp
$Comp
L Thermistor TH1
U 1 1 5A2182E2
P 6050 2250
F 0 "TH1" V 6150 2300 50  0000 C CNN
F 1 "Thermistor" V 5950 2250 50  0000 C BNN
F 2 "" H 6050 2250 50  0001 C CNN
F 3 "" H 6050 2250 50  0001 C CNN
	1    6050 2250
	0    1    1    0   
$EndComp
$Comp
L Conn_WallPlug P1
U 1 1 5A21840C
P 5050 2400
F 0 "P1" H 5000 2575 50  0000 C BNN
F 1 "Conn_WallPlug" V 4825 2400 50  0000 C BNN
F 2 "" H 5450 2400 50  0001 C CNN
F 3 "" H 5450 2400 50  0001 C CNN
	1    5050 2400
	1    0    0    -1  
$EndComp
$Comp
L SW_SPST_Lamp SW1
U 1 1 5A21863B
P 5550 2350
F 0 "SW1" H 5575 2575 50  0000 L CNN
F 1 "SW_SPST_Lamp" H 5600 2250 50  0000 C CNN
F 2 "" H 5550 2650 50  0001 C CNN
F 3 "" H 5550 2650 50  0001 C CNN
	1    5550 2350
	1    0    0    -1  
$EndComp
Wire Wire Line
	7050 2250 7200 2250
Wire Wire Line
	7200 2250 7200 2550
Wire Wire Line
	6750 2250 6650 2250
Wire Wire Line
	6350 2250 6250 2250
Wire Wire Line
	5750 2250 5800 2250
Wire Wire Line
	5800 2250 5850 2250
Wire Wire Line
	5800 2250 5800 2350
Wire Wire Line
	5800 2350 5750 2350
Connection ~ 5800 2250
Wire Wire Line
	7200 2550 7050 2550
Wire Wire Line
	5250 2300 5300 2300
Wire Wire Line
	5300 2300 5300 2250
Wire Wire Line
	5300 2250 5350 2250
Wire Wire Line
	5300 2550 6750 2550
Wire Wire Line
	5350 2350 5300 2350
Wire Wire Line
	5300 2350 5300 2500
Wire Wire Line
	5300 2500 5300 2550
Wire Wire Line
	5250 2500 5300 2500
Connection ~ 5300 2500
$EndSCHEMATC
