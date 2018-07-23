import processing.net.*;

Server server;

float newMessageColor = 255;
String incomingMessage = "";
String typing = "";

void setup() {
  size(400, 200);
  //서버포트를 설정  
  server = new Server(this, 5204);
}

void draw() {
  //배경색을 값에 맞춰 조정함  
  background(newMessageColor);

  //들어오는 메시지를 화면에 뿌림  
  newMessageColor = constrain(newMessageColor + 0.3, 0, 255);
  println(newMessageColor);
  textAlign(CENTER);
  fill(255);
  text(incomingMessage, width/2, height/2);
  
  //클라이언트 객체를 생성하고 클라이언트가 접속을 하는지 확인  
  Client client = server.available();
  
  //클라이언트에서 들어온 메시지를 수정하여 클라이언트에 다시 전송  
  if(client != null) {
    incomingMessage = client.readString();
    incomingMessage = incomingMessage.trim();
    
    println("Client says: " + incomingMessage);
    server.write("기분을 바꾸는데 " + incomingMessage + " 은 어때?\n");
    newMessageColor = 0;
  }
}

//클라이언트가 접속하면 클라이언트의 ip정보를 콘솔에 보여줌  
void serverEvent(Server server, Client client) {
  incomingMessage = "A new client has connected: " + client.ip();
  println(incomingMessage);
  newMessageColor = 0;
}

