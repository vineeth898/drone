#include <Servo.h>
Servo throttle;
Servo roll;
int throttlevalx, Roll;
void setup() {
  Serial.begin(9600);
  throttle.attach(9);
  roll.attach(3);
  throttle.write(50);
  throttlevalx=55;
  roll.attach(3);
  Roll=90;
}

void loop() {
  if (Serial.read() == 'a') {
    for (int x = throttlevalx; x <= 100; x++) {
      delay(20);
      Serial.println(throttlevalx);
      throttle.write(x);
      throttlevalx = x;
    }
      Serial.println(throttlevalx);
  }
  else if (Serial.read() == 'b') {
    
    for (int x = throttlevalx;x >= 50; x--) {
      delay(10);
      Serial.println(throttlevalx);
      throttle.write(x);
      throttlevalx = x;
    }
      Serial.println(throttlevalx);
  }
  else if (Serial.read() == 'c') {
    for (int y = Roll; y < 180; y++) {
      delay(10);
      roll.write(y);
      Roll = y;
    }
  }
  else if (Serial.read() == 'd') {
    for (int y = Roll; y > 0; y--) {
      delay(10);
      roll.write(y);
      Roll = y;
    }
  }
  else if (Serial.read() == 'f') {
      roll.write(90);
      Roll = 90;
    }
  
}
