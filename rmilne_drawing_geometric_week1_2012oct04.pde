/*

Rae Milne - Slow Code
Drawing Program

Inspired by Lara Schenck
http://notlaura.com/studioblog

*/

import processing.serial.*;
import cc.arduino.*;

Arduino arduino;

int buttonA = 2; //set button to Pin 2
int buttonB = 3; //set button to Pin 3
int buttonC = 7; //set left button to Pin 7
int buttonD = 8; //set right button to Pin 8

int potmtrA = 0; //set potentiometer to A0
int potmtrB = 2; //set potentiometer to A2

float potX = 0; //potentiometer X-coordinate
float potY = 0; //potentiometer Y-coordinate

void setup() {
  
//set up canvas
  
  size(750, 750); //screen size
  smooth();
  noFill();
  background(255); //white background

//declare arduino

  arduino = new Arduino(this, Arduino.list()[0], 57600);

//Specify pins as inputs

  arduino.pinMode(buttonA, Arduino.INPUT);
  arduino.pinMode(buttonB, Arduino.INPUT);
  arduino.pinMode(buttonC, Arduino.INPUT);
  arduino.pinMode(buttonD, Arduino.INPUT);

  arduino.pinMode(potmtrA, Arduino.INPUT);
  arduino.pinMode(potmtrB, Arduino.INPUT);
}


void draw() {
  
//declare variables
  
  float circ_size = random(0,400); //randomize circle sizes
  float sq_size = random(0, 300); //randomize square sizes
  float stroke_color = random(50, 220); //randomize stroke color
  float stroke_weight = random(0.5,2); //randomize stroke weight
  
 
  stroke(stroke_color);           //randomize the stroke color
  strokeWeight(stroke_weight);    //randomize the stroke weight

//draw lines
   
  potX = arduino.analogRead(potmtrA);
  potY = arduino.analogRead(potmtrB);
  
  potX = constrain(potX, 25, width - 25); //set boundaries to X-coordinate
  potY = constrain(potY, 25, height - 25); //set boundaries to Y-coordinate
  
  float ppotX = potX;
  float ppotY = potY;
  
  line(ppotX, ppotY, potX, potY); //create line based on location of potentiometer

  
//draw circles
   
  if (arduino.digitalRead(buttonA) == Arduino.LOW) { 
    ellipse(potX, potY, circ_size, circ_size);
    delay(250);
  }
  
//draw squares

  if (arduino.digitalRead(buttonB) == Arduino.LOW) {
    rect(potX-(sq_size/2), potY-(sq_size/2), sq_size, sq_size);
    delay(250);
  }
  
//fill shapes

  if (arduino.digitalRead(buttonC) == Arduino.LOW) {
    fill(220, 150);
  } else {
    noFill();
  }
   
//erase button
  
   if (arduino.digitalRead(buttonD) == Arduino.LOW) {
     background(255);
   } 
}
  
