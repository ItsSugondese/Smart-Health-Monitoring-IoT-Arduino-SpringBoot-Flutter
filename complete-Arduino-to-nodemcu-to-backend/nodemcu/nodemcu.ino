
#include <WiFi.h>
#include <HTTPClient.h>
// #include <ESP8266HTTPClient.h>

// const char* ssid     = "Shey-Phoksundo";
// const char* password = "R@isecom22";

const char* ssid     = "Gosaikunda";
const char* password = "R@isecom22";

const char* host = "192.168.42.211";
const int httpPort = 6969;

int temp = 0;
int hum = 0;
int bpm = 0;
void setup()
{
  Serial.begin(9600);
   WiFi.begin(ssid, password);
  Serial.println("Connecting");
  while(WiFi.status() != WL_CONNECTED) {
    delay(2000);
    Serial.println("Connecting to WiFi...");
  }
Serial.println("Connected");  
}

void loop()
{
  if (Serial.available()){ //check of serial data is available or not
    
    String payload = Serial.readStringUntil('\r\n');
    if(payload.substring(0, payload.indexOf(" "))== "Temp:"){  
      temp=  (payload.substring(payload.indexOf(" ")+1, payload.length())).toInt();
  
    }

    if(payload.substring(0, payload.indexOf(" "))== "Hum:"){
      hum =  (payload.substring(payload.indexOf(" ")+1, payload.length())).toInt();
    }

    if(payload.substring(0, payload.indexOf(" "))== "BPM:"){
      bpm =  (payload.substring(payload.indexOf(" ")+1, payload.length())).toInt();
    }
    
  
    
  

  if(temp !=0 && hum !=0){
    if(WiFi.status()== WL_CONNECTED){
 HTTPClient http;

Serial.printf("temperature is %d\n", temp);
Serial.printf("humidity is %d\n", hum);

 //posting value from dht11
      http.begin(host, httpPort, "/dht/add");
      http.addHeader("Content-Type", "application/json");

     String dht = "{\"temperature\":\"" + String(temp) + "\",\"humidity\":\"" + String(hum) + "\"}";

      int httpResponseCode = http.POST(dht);
      String response = http.getString();

      Serial.print("HTTP Response code: ");
      Serial.println(httpResponseCode);
      Serial.println(response);
      http.end();
      temp = 0;
      hum = 0;
  }

  }

  if(bpm !=0){
    if(WiFi.status()== WL_CONNECTED){
 HTTPClient http;


 //posting value from dht11
      http.begin(host, httpPort, "/pulse/add");
      http.addHeader("Content-Type", "application/json");

Serial.printf("BPM is %d\n", bpm);
      String pulse = "{\"bpm\":\"" + String(bpm) + "\"}";

      int httpResponseCode = http.POST(pulse);
      String response = http.getString();

      Serial.print("HTTP Response code: ");
      Serial.println(httpResponseCode);
      Serial.println(response);
      http.end();

      bpm = 0;
  }
}
  }
}

  
