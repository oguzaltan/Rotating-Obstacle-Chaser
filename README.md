# Rotating_Obstacle_Chaser

YouTube video link: 
https://youtu.be/qoW3Q4s6ehM

Detailed report with related photos **EEE102 Digital Design Course Project Report Oğuz Altan.pdf** can be found in this repo. 

## Abstract / Objective
Aim of this project is make a rotating obstacle chaser. I use a servo motor and ultrasonic sensor 
to measure the distance. The sensor is mounted on the top of motor, so it rotates due to motor’s 
constant rotation. The distance detected by ultrasonic sensor goes to BASYS 3 FPGA. When sensor 
detects an object within a predetermined range by user, buzzer turns on and warn. 

## The Design Specification Plan
Components and Tools

• BASYS 3
• SG90 Servo Motor
• Arduino and prototype Shield as 5V Power Source
• Breadboard and Wires
• 5V Active Buzzer

Starting from servo motor, it is a motor that is used to move the tip of it to some predetermined 
degrees. It takes the information signal to what degrees it must go from BASYS 3 FPGA board. 

In this project, it is used to move from 0 degrees to 180 degrees without any wait, namely it goes 
and comes back constantly. A technique called PWM (Pulse Width Modulation) is used to control 
it. 

As it can be seen from the figure 2, in every 20ms, a square wave signal is sent to motor to inform 
it to where it should go. To rotate it to -90 degrees, in this signal, where must be a high signal 
during 1 ms of these 20 ms signal and for +90 degrees this high should be 2 ms. 
On the top of this motor, ultrasonic sensor is mounted. Ultrasonic sensor is used to measure the 
distance to some objects in front of it, using sound waves.

When it gets high signal to its trigger inputs, it emits 8 40 kHz sound waves and these waves 
bounce from the object in the front and comes back to sensor and it receives them. To measure 
the distance, the time between the receptions of the signals is used. The simple physics formula 
X = V.t is used here, as we can calculate time (t) and we know the speed of the soundwaves in a 
room. 
Finally, consider that the distance between the sensor and object is half of the way that sound 
waves takes as they go and bounce, come again to sensor.

This formula is used to measure the speed of soundwaves in a room with temperature T (degrees).
To warm the user, a 5V Active Buzzer is used. When ultrasonic sensor detects an objects withing 
a range determined by user, it sends a high signal to buzzer and buzzer turns on.

Arduino is used to give 5V DC power to the circuit. Also a protoype shield and a breadboard is 
mounted to Arduino, all the external circuit is implemented on this breadboard.

Finally, BASYS 3 FPGA Board is the brain of this project, main control device that controls all of 
these external components and programmed using VHDL on Vivado program on computer. 
Inputs and outputs of BASYS 3 are used and also seven segment display on it is used.

The range that is scanned by the ultrasonic sensor can be set by switches on the BASYS 3 board. 
For example, when the first switch is set to high, then the sensor scans for object within 10 cm. It 
is 20 cm for second swtich and 30 cm for third switch. The distance measured by sensor is always 
displayed on the seven segment display on the BASYS 3 board, so that user can see the distance. 

## The Design Methodology
Servo motor has 3 connections, Vcc, ground and signal input. Vcc and ground areprovided by 
Arduino and implemented on breadboard. Signal input is connected to JA1 IO of BASYS 3. 
Ultrasonic sensor has 4 connections, Vcc, ground, trigger and echo. Vcc and ground are again 
conncted to breadboard. Trigger is connected to JB1 and echo is connected to JB2 IO of BASYS 3 
board. With an plastic apparatus, sensor is mounted on the top of motor. This combinations is 
put inside a box, so that sensor is on the top of the box scannnig the area and motor is in the box. 
Buzzer’s high is connected to JA2 of the BASYS 3 and its ground is connected to common ground 
on the breadboard. So when distance sensor detects some objects, it sends high signal to buzzer. 
Finally, BASYS 3 and Arduino are connected to computer via USB. 

As it can be seen from the RTL Schematics, in the top module digitalsensor_topmodule, there 
are 3 modules and distance_sensor module contains sevensegment_decoder module. All of the 
inputs and outputs are shown. 

## Conclusion
This project is made to scan objects in an area and chase objects. Servo motor, ultrasonic 
sensor, buzzer, BASYS 3 FPGA board and other components are used for it. So, a mechanism is 
constructed. This allows user to detect objects in a range preset by user him/herself. Switches 
on the BASYS 3 are used. 
