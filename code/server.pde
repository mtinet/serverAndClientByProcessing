import processing.net.*;

Server server;
PFont f;

float newMessageColor = 255;
String incomingMessage = "";
String typing = "";

void setup() {
  //창의크기는 아래 둘 중에 하나만 선택해야 함  
  size(400, 200); //창의 크기를 400, 200으로 사용하려면 주석을 해제하세요. 
  //fullScreen(); //풀스크린을 사용하려면 주석을 해제하세요.  
  
  server = new Server(this, 5204);
  f = createFont("NanumGothic-48", 60);
}

void draw() {
  background(newMessageColor);

  newMessageColor = constrain(newMessageColor + 0.3, 0, 255);
  println(newMessageColor);
  textFont(f);
  textSize(12);
  textAlign(CENTER);
  fill(255);
  text(incomingMessage, width/2, height/2);
  
  //문자를 작성하고 엔터를 눌러 서버로 보낸다는 메시지를 안내함  
  fill(0);
  text("클라이언트의 메시지가 아래에 표시됩니다.", width/2, 20);
  fill(0);
  text(typing, width/2, 80);
  
  Client client = server.available();
  
  if(client != null) {
    incomingMessage = client.readString();
    incomingMessage = incomingMessage.trim();
    
    println("Client says: " + incomingMessage);
    server.write("기분을 바꾸는데 " + incomingMessage + " 은 어때?\n");
    newMessageColor = 0;
  }
}

void serverEvent(Server server, Client client) {
  incomingMessage = "A new client has connected: " + client.ip();
  println(incomingMessage);
  newMessageColor = 0;
}

