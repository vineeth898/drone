// Daniel Shiffman
// Tracking the average location beyond a given depth threshold
// Thanks to Dan O'Sullivan

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

import org.openkinect.freenect.*;
import org.openkinect.processing.*;
import processing.serial.*;
Serial arduino;
// The kinect stuff is happening in another class
KinectTracker tracker;
Kinect kinect;
float prevx,prevy;
boolean state=false;
 void setup() {
  size(640, 520);
  kinect = new Kinect(this);
  tracker = new KinectTracker();
arduino=new Serial(this,"/dev/tty.usbmodem143401",9600);
}

void draw() {
  background(255);
  // Run the tracking analysis
  tracker.track();
  // Show the imageq
  tracker.display();
  // Let's draw the raw location
  PVector v1 = tracker.getPos();
  if(state){
  if(prevx-v1.x>100 || prevx-v1.x<-100 || prevy-v1.y>80 || prevy-v1.y<-80){
  fill(0,0,0);
  noStroke();
  for(int x=0;x<15;x++){
  arduino.write('f');
  delay(5);
  }
  delay(1000);
  prevx=v1.x;
  prevy=v1.y;
  }
  else if(prevx-v1.x>80){
  fill(255,255,0);
  for(int x=0;x<15;x++){
  arduino.write('d');
  delay(5);
  }
  prevx=v1.x;
  }
  else if(prevx-v1.x<-80){
  fill(0,255,255);
  for(int x=0;x<15;x++){
  arduino.write('c');
  delay(5);
  }
  prevx=v1.x;
  }
  else if(prevy-v1.y>50){
  fill(255,0,255);
  for(int x=0;x<15;x++){
  arduino.write('a');
  delay(5);
  }
  prevy=v1.y;
  }
  else if(prevy-v1.y<-50){
  fill(0,255,0);
  for(int x=0;x<15;x++){
  arduino.write('b');
  delay(5);
  }
  prevy=v1.y;
  }
  ellipse(v1.x, v1.y, 20, 20);
  text("v1="+v1.x+" ,x="+prevx +"prevx-v1.x="+(prevx-v1.x),20,510);
  }
}

void keyPressed() {
 if(key=='q'){
   if(!state)
   state=true;
   else
   state=false;arduino.write("b");
 } 
 if(key==' '){
   state=false;
   for(int x=0; x<50;x++){
   arduino.write("b");
   delay(10);
   arduino.write("f");
   delay(10);
   }
 } 
}
