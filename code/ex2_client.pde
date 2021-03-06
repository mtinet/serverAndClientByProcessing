import processing.net.*;
// Declare a client
Client client;
 
// Used to indicate a new message
float newMessageColor = 0;
// A String to hold whatever the server says
String messageFromServer = "";
// A String to hold what the user types
String typing ="";
 
PFont f;
 
void setup() {
  size(400,200);
  // Create the Client, connect to server at 127.0.0.1 (localhost), port 5204
  client = new Client(this,"127.0.0.1", 5204);
  f = createFont("Arial",16,true);
 
}
 
void draw() {
  background(255);
 
  // Display message from server
  fill(newMessageColor);
  textAlign(CENTER);
  text(messageFromServer,width/2,100);
 
  // Fade message from server to white
  newMessageColor = constrain(newMessageColor+1,0,255); 
 
  // Display Instructions
  fill(0);
  textAlign(LEFT);
  text(" Nickname: ",80,50);
  // Display text typed by user
  fill(0);
  text(typing,145,50);
 
  // If there is information available to read
  // (we know there is a message from the Server when there are greater than zero bytes available.)
  if (client.available() > 0) { 
    // Read it as a String
    messageFromServer = client.readString();
    // Set brightness to 0
    newMessageColor = 0;
  }
}
 
// Simple user keyboard input
void keyPressed() {  
  // If the return key is pressed, save the String and clear it
  if (key == '\n') {
    // When the user hits enter, write the sentence out to the Server
    println("ok");
    client.write(typing);
    typing = "";
  } else {
    typing = typing + key;
  }
}
