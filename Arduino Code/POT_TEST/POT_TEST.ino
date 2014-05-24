int potPin = A0;    // select the input pin for the potentiometer
int val1 = 0;
int val2 = 0;
int diff = 0;
void setup() {
  Serial.begin(9600);
}

void loop() {
  val1 = analogRead(potPin);  // read the value from the sensor
  val1 = map(val1, 0, 1023, 0, 100);
  delay (50);
  val2 = analogRead(potPin);  // read the value from the sensor
  val2 = map(val2, 0, 1023, 0, 100);
  diff = val2 - val1;
  Serial.println(diff);
    }

