//motor stuff
#include <Servo.h>

//int movetime = 0;
//thumb potentiometer controller
const int THUMBPOT = A0;
int thumbpotval = 0;
const int FINGERSPOT = A1;
int fingerspotval1 = 0;
int fingerspotval2 = 0;
int indexdiff = 0;
float indexstep = 0;
int indexinc = 0;
int indexangle = 0;

//int thumbanglediff = 0;

//thumb
const int THUMB = 4;
Servo thumbservo;

const int INDEX = 5;
Servo indexservo;

const int MIDDLE = 8;
Servo middleservo;

const int RINGANDPINKEY = 9;
Servo ringandpinkeyservo;

//limiter potentiometer motor control stuff
//const int THUMBLIMITPOT = A2;
//int thumblimitval1 = 0;
//int thumblimitval2 = 0;
//int thumblimitdiff = 0;
//const int INDEXLIMITPOT = A5;//not final val
//int indexlimitval = 0;


//pneumatic stuff
const int VACRELAY = 2;
const int VALVERELAY = 3;
const int VACBUTTON = 11;
const int VALVEBUTTON = 12;
int vacbuttonstate = 0;
int valvebuttonstate = 0;

void setup() {
// put your setup code here, to run once:

//motor initialization
thumbservo.attach(THUMB);
pinMode(4, OUTPUT);
pinMode(THUMB, OUTPUT);

indexservo.attach(INDEX);
pinMode(5, OUTPUT);
pinMode(INDEX, OUTPUT);

middleservo.attach(MIDDLE);
pinMode(8, OUTPUT);
pinMode(MIDDLE, OUTPUT);

ringandpinkeyservo.attach(RINGANDPINKEY);
pinMode(9, OUTPUT);
pinMode(RINGANDPINKEY, OUTPUT);

Serial.begin(9600);

//pneumatic initialization
pinMode(2, OUTPUT);
pinMode(3, OUTPUT);
pinMode(11, INPUT);
pinMode(12, INPUT);
pinMode(VACRELAY, OUTPUT);
pinMode(VALVERELAY, OUTPUT);
pinMode(VACBUTTON, INPUT);
pinMode(VALVEBUTTON, INPUT);

fingerspotval1 = analogRead(FINGERSPOT);
fingerspotval1 = map(fingerspotval1, 0, 1023, 10, 170);
fingerspotval2 = fingerspotval1;

}

void loop() {
  // put your main code here, to run repeatedly: 
  
  thumbpotval = analogRead(THUMBPOT);
  thumbpotval = map(thumbpotval, 0, 1023, 10, 170);
  thumbservo.write(thumbpotval);
  delay(5);
  
  fingerspotval2 = analogRead(FINGERSPOT);
  fingerspotval2 = map(fingerspotval2, 0, 1023, 10, 170);
  Serial.println(fingerspotval2);
  indexdiff = fingerspotval2 - fingerspotval1; 

  if (indexdiff > 100)
  {
    indexstep = indexdiff/5;
    indexinc = ceil(indexstep);
    indexangle = fingerspotval1 + indexinc;
    for (int i = 0; i<5; i++)
    {
      indexservo.write(indexangle);
      delay(1000);
      indexangle = indexangle + indexinc;
    }
    fingerspotval1 = analogRead(FINGERSPOT);
    fingerspotval1 = map(fingerspotval1, 0, 1023, 10, 170);
    fingerspotval2 = fingerspotval1;
  }
  if (indexdiff <0)
  {
    indexservo.write(fingerspotval2);
  }
  
  
  
  
  
 // indexservo.write(fingerspotval);
 // delay(5);
//  fingerspotval = analogRead(FINGERSPOT);
//  fingerspotval = map(fingerspotval, 0, 1023, 10, 170);
//  middleservo.write(fingerspotval);
//  delay(5);
//  fingerspotval = analogRead(FINGERSPOT);
//  fingerspotval = map(fingerspotval, 0, 1023, 10, 170);
//  ringandpinkeyservo.write(fingerspotval);
//  delay (5);
//}

//pneumatic stuff
 vacbuttonstate = digitalRead(VACBUTTON);
 valvebuttonstate = digitalRead(VALVEBUTTON);
 
 if (vacbuttonstate == HIGH)digitalWrite(VACRELAY,HIGH);
 if (vacbuttonstate == LOW)digitalWrite(VACRELAY,LOW);
 if (valvebuttonstate == HIGH)digitalWrite(VALVERELAY,HIGH);
 if (valvebuttonstate == LOW)digitalWrite(VALVERELAY,LOW);
}


