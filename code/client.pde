import processing.net.*;

Client client;

float newMessageColor = 0;
String messageFromServer = "";
String typing = "";

void setup() {
  size(400, 200);
  //접속할 서버의 ip, port를 지정하여 클라이언트 객체를 생성  
  client = new Client(this, "localhost", 5204);
}

void draw() {
  //배경을 지정  
  background(255);
  
  //서버로부터 온 메시지를 화면에 뿌림  
  fill(newMessageColor);
  textAlign(CENTER);
  text(messageFromServer, width/2, 140);
  newMessageColor = constrain(newMessageColor + 1, 0, 255);
  println(newMessageColor);
  
  //문자를 작성하고 엔터를 눌러 서버로 보낸다는 메시지를 안내함  
  fill(0);
  text("Type text and press Enter to send to server.", width/2, 60);
  fill(0);
  text(typing, width/2, 80);
}

// 클라이언트 이벤트가 있을 때 엔터까지의 문자열을 입력받아 msg변수에 넣고, msg 변수가 비어있지 않으면, messageFromServer변수에 넣음  
void clientEvent(Client client) {
  String msg = client.readStringUntil('\n');
  if(msg != null) {
    messageFromServer = msg;
    newMessageColor = 0;
  }
}


//키가 눌러지면 그것을 순서에 맞춰 저장하고, 엔터가 들어오면 클라이언트로 저장된 내용을 전송  
void keyPressed() {
  if(key == '\n') {
    server.write(typing);
    typing = "";
  } else {
    typing = typing + key;
  }
}
