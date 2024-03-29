#include <RogueMP3.h>
#include <NewSoftSerial.h>
#define _song1 "/Ringtone.mp3"
#include <Ethernet.h>
#include <SPI.h>


NewSoftSerial rmp3_serial(6, 7);
RogueMP3 rmp3(rmp3_serial); 
 
boolean reading = false;

////////////////////////////////////////////////////////////////////////
//CONFIGURE
////////////////////////////////////////////////////////////////////////
  byte ip[] = { 172, 16, 27, 100 };   //ip address to assign the arduino
  byte gateway[] = {172, 16, 27, 1 }; //ip address of the gateway or router
  //Rarly need to change this
  byte subnet[] = { 255, 255, 255, 0 };
  // if need to change the MAC address (Very Rare)
  byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
  Server server = Server(80); //port 80
  
  // SENSOR
  int SensorPin = A0;
  int erreur = 500;    
  
  // Push Button
  int inPin = 6;
  int val = 0; 

  // Connexion to local Server
  byte proxyIP[] = { 172, 16, 27, 99 }; // rxProxy
  int proxyPort=2000;


////////////////////////////////////////////////////////////////////////
// S.E.T U.P
////////////////////////////////////////////////////////////////////////
void setup(){
  //Pins 10,11,12 & 13 are used by the ethernet shield
  pinMode(9, OUTPUT);
  pinMode(inPin, INPUT);    // declare pushbutton as input

  Ethernet.begin(mac, ip, gateway, subnet);
  server.begin();
  triggerPin(9,NULL);
  Serial.begin(9600);
  
  // Play Test MP3
  rmp3_serial.begin(9600);
  rmp3.sync();
  rmp3.playfile(_song1);
  
  delay(1000);

  Serial.println("Begin Serial ...");
}


////////////////////////////////////////////////////////////////////////
// L.O.O.P
////////////////////////////////////////////////////////////////////////
void loop()
{
  // listen for Sensor
  checkForSensor();
  delay(2);
  // listen for incoming clients, and process qequest.
  checkForClient();
  delay(2);
  // listen for Push Button
  checkForButton();
  delay(2);
}

// *********************************
// P.U.S.H  B.U.T.T.O.N
// *********************************
void checkForButton()
{  
   val = digitalRead(inPin);  // read input value
  
  if (val == LOW) {    
    
    triggerPin(9,NULL);
    
    // Like
    char toString[255];
    toString[0]='\0';
    sprintf(toString, "LIKE");
  

    Client client(proxyIP, proxyPort);
    if (client.connect()) {
      client.println(toString);
      client.stop();
    }
    Serial.println(toString);
    
    delay(200);
  }
}
// *********************************
// S.E.N.S.O.R
// *********************************
void checkForSensor()
{  
  int analogValue = analogRead(SensorPin);
  
  if (analogValue > erreur)
  {
    // Turn the led on
    triggerPin(9,NULL);
    
    // Display value
    char toString[255];
    toString[0]='\0';
    sprintf(toString, "SWITCH");
  

    Client client(proxyIP, proxyPort);
    if (client.connect()) {
      client.println(toString);
      client.stop();
    }
    Serial.println(toString);
    
    delay(200);
  }
}

// *****************************
// E.T.H.E.R.N.E.T
// *****************************
void checkForClient(){

  Client client = server.available();
 
  if (client){
    boolean isblank=true;
    char cmd[255];
    cmd[0]='\0';
    while(client.connected())
    {
       if (client.available())
       {
         char c=client.read();
         Serial.println(c);       
         char cString[2];
         cString[0]=c;
         cString[1]='\0';
         if ( (c!='\n') && (c!='\r'))
           strcat(cmd,cString);
         //strcat(cmd,&c);
         //client.println(c);
           
         if (c=='\n'){
         Serial.println(cmd);           
         char keyword[10];
         keyword[0]='\0';
         strncat(keyword, cmd, 4);
         Serial.println(keyword);
        
         
           if (!strcmp(keyword,"PMP3"))
           {
            char* song;
            song=cmd+4; 
            Serial.println(song);
            // Play Song
            rmp3_serial.begin(9600);
            rmp3.sync();
            client.println("ok"); // Return OK
            rmp3.playfile(song);
            
              
            triggerPin(9,client);
           }
           if (!strcmp(cmd,"Hello"))
           {
              client.println("ok");
              
                triggerPin(9,client);  
           }
           client.stop(); // close the connection:  
         }
          
       } /* Fin connected */  
     
    }  /* Fin while */
   delay(1);
   
}/* fin if Client */
  
}

void triggerPin(int pin, Client client){
for (int i=1;i<10;i++)
{
  digitalWrite(pin, HIGH);
  delay(25);
  digitalWrite(pin, LOW);
  delay(25);
}
}
