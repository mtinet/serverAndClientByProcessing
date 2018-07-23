import processing.net.*;

Client client;

float newMessageColor = 0;
String messageFromServer = "";
String typing = "";

void setup() {
  size(400, 200);
  client = new Client(this, "localhost", 5204);
}

void draw() {
  background(255);
  fill(newMessageColor);
  textAlign(CENTER);
  text(messageFromServer, width/2, 140);
  newMessageColor = constrain(newMessageColor + 1, 0, 255);
  println(newMessageColor);
  
  fill(0);
  text("Type text and press Enter to send to server.", width/2, 60);
  fill(0);
  text(typing, width/2, 80);
}

void clientEvent(Client client) {
  String msg = client.readStringUntil('\n');
  if(msg != null) {
    messageFromServer = msg;
    newMessageColor = 0;
  }
}
  
void keyPressed() {
  if(key == '\n') {
    client.write(typing);
    typing = "";
  } else {
    typing = typing + key;
  }
}
