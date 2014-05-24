//motor stuff
#include <Servo.h>

//int movetime = 0;
//thumb potentiometer controller
const int THUMBPOT = A0;
int thumbpotval = 0;
const int FINGERSPOT = A1;
int fingerspotval = 0;
//int thumbpotval2 = 0;
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
}

void loop() {
  // put your main code here, to run repeatedly: 

//thumb control
//check if limit pot is moving
    //thumblimitval1 = analogRead(THUMBLIMITPOT);//(7-914 #3)
        //thumblimitval1 = map(thumblimitval1, 7, 904, 1, 100);
    //delay (10);
    //thumblimitval2 = analogRead(THUMBLIMITPOT);
        //thumblimitval2 = map(thumblimitval2, 7, 904, 1, 100);
    //thumblimitdiff = thumblimitval2 - thumblimitval1;
//check to see if thumb control pot is moving
  //  thumbpotval1 = analogRead(THUMBPOT);
  //  thumbpotval1 = map(thumbpotval1, 0, 1023, 10, 160);
  //  delay (10);
  //  thumbpotval2 = analogRead(THUMBPOT);
  //  thumbpotval2 = map(thumbpotval2, 0, 1023, 10, 160);
  //  thumbanglediff = thumbpotval2 - thumbpotval1;

//for (int movetime = 0; movetime <= 1000; movetime++)
//{
  thumbpotval = analogRead(THUMBPOT);
  thumbpotval = map(thumbpotval, 0, 1023, 10, 170);
  thumbservo.write(thumbpotval);
  delay(5);

  fingerspotval = analogRead(FINGERSPOT);
  fingerspotval = map(fingerspotval, 0, 1023, 10, 170);
  indexservo.write(fingerspotval);
  delay(5);
  fingerspotval = analogRead(FINGERSPOT);
  fingerspotval = map(fingerspotval, 0, 1023, 10, 170);
  middleservo.write(fingerspotval);
  delay(5);
  fingerspotval = analogRead(FINGERSPOT);
  fingerspotval = map(fingerspotval, 0, 1023, 10, 170);
  ringandpinkeyservo.write(fingerspotval);
  delay (5);
//}

//pneumatic stuff
 vacbuttonstate = digitalRead(VACBUTTON);
 valvebuttonstate = digitalRead(VALVEBUTTON);
 
 if (vacbuttonstate == HIGH)digitalWrite(VACRELAY,HIGH);
 if (vacbuttonstate == LOW)digitalWrite(VACRELAY,LOW);
 if (valvebuttonstate == HIGH)digitalWrite(VALVERELAY,HIGH);
 if (valvebuttonstate == LOW)digitalWrite(VALVERELAY,LOW);
}


