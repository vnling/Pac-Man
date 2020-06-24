const int red = A0;
const int yellow = A1;
const int blue = A2;
const int green = A3;
const int pot = A4;

void setup() {
  //setting up serial and pins - four switches, one potentiometer
  Serial.begin(9600);
  pinMode(red, INPUT);
  pinMode(yellow, INPUT);
  pinMode(blue, INPUT);
  pinMode(green, INPUT);
  pinMode(pot, INPUT);
}

void loop() {
  // reading from potentiometer
  int potRead = analogRead(pot);
  //mapping to between 0 and 4 (because 5 game levels)
  potRead = map(potRead, 0, 1023, 0, 4);

  //printing (switchInput,potInput)
  if (digitalRead(red) == HIGH) {
    Serial.print(1);
    Serial.print(",");
    Serial.println(potRead);
  } else if (digitalRead(yellow) == HIGH) {
    Serial.print(2);
    Serial.print(",");
    Serial.println(potRead);
  } else if (digitalRead(blue) == HIGH) {
    Serial.print(3);
    Serial.print(",");
    Serial.println(potRead);
  } else if (digitalRead(green) == HIGH) {
    Serial.print(4);
    Serial.print(",");
    Serial.println(potRead);
  } else {
    Serial.print(0);
    Serial.print(",");
    Serial.println(potRead);
  }
}
