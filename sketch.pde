#include <Ethernet.h>
#include <SPI.h>
boolean reading = false;

////////////////////////////////////////////////////////////////////////
//CONFIGURE
////////////////////////////////////////////////////////////////////////
  byte ip[] = { 192, 168, 0, 199 };   //ip address to assign the arduino
  byte gateway[] = { 192, 168, 0, 1 }; //ip address of the gatewa or router

  //Rarly need to change this
  byte subnet[] = { 255, 255, 255, 0 };

  // if need to change the MAC address (Very Rare)
  byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };

  Server server = Server(80); //port 80
////////////////////////////////////////////////////////////////////////

void setup(){
  //Pins 10,11,12 & 13 are used by the ethernet shield
  pinMode(9, OUTPUT);

  Ethernet.begin(mac, ip, gateway, subnet);
  server.begin();
  
}

void loop(){

  // listen for incoming clients, and process qequest.
  checkForClient();

}

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
         char cString[2];
         cString[0]=c;
         cString[1]='\0';
         if ( (c!='\n') && (c!='\r'))
           strcat(cmd,cString);
         //strcat(cmd,&c);
         //client.println(c);
         if (c=='\n'){
           client.println(cmd);
           if (!strcmp(cmd,"hello"))
           {
              client.println("ok");
              triggerPin(9,client);
           }
          if (!strcmp(cmd,"world"))
           {
              client.println("ok");
              triggerPin(7,client);
           }
           client.stop(); // close the connection:  
         }
          
       } /* Fin connected */  
     
    }  /* Fin while */
   delay(1);
   
}/* fin if Client */
  
}

void triggerPin(int pin, Client client){
//blink a pin - Client needed just for HTML output purposes.  
  client.print("Turning on pin ");
  client.println(pin);
for (int i=1;i<10;i++)
{
  digitalWrite(pin, HIGH);
  delay(25);
  digitalWrite(pin, LOW);
  delay(25);
}
}
