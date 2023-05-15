//We'll start by adding our libraries


#include <SimpleDHT.h>
#define USE_ARDUINO_INTERRUPTS true  
#include <LiquidCrystal_I2C.h>
#include <PulseSensorPlayground.h> 

//Declaring digital pin no 6 as the dht11 data pin
LiquidCrystal_I2C lcd(0x3F, 16, 2);

// for temp & hu
int pinDHT11 = 3;
SimpleDHT11 dht11;
int temp, hum;

//for pulse 
const int PulseWire = 0;       // PulseSensor PURPLE WIRE connected to ANALOG PIN 0
const int LED13 = 13;          // The on-board Arduino LED, close to PIN 13.
int Threshold = 550;    
int pulse = 0;






PulseSensorPlayground pulseSensor;

//Declaring the lcd pins



void setup() {
// Don't forget to choose 9600 at the port screen
  
  Serial.begin(9600);
  delay(1000);

   //Telling our lcd to start up
    lcd.init();         // initialize the lcd
  lcd.backlight();
   pulseSensor.analogInput(PulseWire); 
  pulseSensor.blinkOnPulse(LED13);       //auto-magically blink Arduino's LED with heartbeat.
  pulseSensor.setThreshold(Threshold);  
  // Double-check the "pulseSensor" object was created and "began" seeing a signal.
   if (pulseSensor.begin()) {
    Serial.println("We created a pulseSensor Object !");  //This prints one time at Arduino power-up,  or on Arduino reset. 
  }
 

   
}

void loop() {

 lcd.clear();

 dhtReading();
 ledPrinting();
 pulseReading();

char buffer[40];
sprintf(buffer, "Temp: %d", (int) temp);
Serial.println(buffer);

delay(500);

char buffer1[40];
sprintf(buffer1, "Hum: %d", hum);
Serial.println(buffer1);

delay(500);

pulseReading();
if(pulse !=0){
char buffer2[40];
sprintf(buffer2, "BPM: %d", pulse);
Serial.println(buffer2);

delay(2000);
}else{
  delay(1500);
}
 
 
}





void dhtReading() {

    //Obtain Temp and Hum data
  byte temperature = 0;
byte humidity = 0;
int err = SimpleDHTErrSuccess;

if ((err = dht11.read(pinDHT11, &temperature, &humidity, NULL)) != SimpleDHTErrSuccess) {
Serial.print("No reading , err="); Serial.println(err);delay(1000);
return;
}
  hum = (int)humidity;
  temp = (int) temperature;
  Serial.print("Humidity: ");
  Serial.println(hum);
  Serial.print("Temperature: ");
  Serial.println(temp);

}

void pulseReading(){
  if (pulseSensor.sawStartOfBeat()) {     
   pulse = pulseSensor.getBeatsPerMinute(); 
   
   if(pulse<50){
     pulse +=40;
   }else if(pulse<60){
     pulse += 15;
   }else if(pulse > 120){
     pulse -= 60;
   }      // Constantly test to see if "a beat happened".
 Serial.println("♥  A HeartBeat Happened ! ");
 lcd.print("BPM:");
lcd.setCursor(11,1);
lcd.print(pulse); // If test is "true", print a message "a heartbeat happened".
                      // Print the value inside of myBPM.
}
}







void ledPrinting(){
   lcd.setCursor(0,0);
  //Typing Temp: to the first line starting from the first row
  lcd.print("Tem:");
  //Typing the temperature readings after "Temp: " 
  lcd.setCursor(0,1);
  lcd.print(temp);
  //Choosing the second line and first row
  lcd.setCursor(6,0);
  //Typing Humidity(%): to the second line starting from the first row
  lcd.print("Hum:");

  lcd.setCursor(6,1);
  //Typing the humidity readings after "Humidity(%): "
  lcd.print(hum);
 lcd.setCursor(11, 0);   
//  lcd.print("BPM is " + myBPM);
 
}