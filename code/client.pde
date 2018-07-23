import processing.net.*;

Client client;

float newMessageColor = 0;
String messageFromServer = "";
String typing = "";
PFont f;

void setup() {
  //창의크기는 아래 둘 중에 하나만 선택해야 함  
  //size(400, 200); //창의 크기를 400, 200으로 사용하려면 주석을 해제하세요. 
  fullScreen(); //풀스크린을 사용하려면 주석을 해제하세요.  
  
  //접속할 서버의 ip, port를 지정하여 클라이언트 객체를 생성  
  client = new Client(this, "192.168.100.37", 5204);
  f = createFont("NanumGothic-60", 60);
}

void draw() {
  //배경을 지정  
  background(255);
  
  //서버로부터 온 메시지를 화면에 뿌림
  textFont(f);
  fill(newMessageColor);
  textAlign(CENTER);
  text(messageFromServer, width/2, height*2/3);
  newMessageColor = constrain(newMessageColor + 1, 0, 255);
  println(newMessageColor);
  
  //문자를 작성하고 엔터를 눌러 서버로 보낸다는 메시지를 안내함  
  fill(0);
  text("텍스트를 입력하고, 엔터를 누르세요.", width/2, 60);
  fill(0);
  text(typing, width/2, height/3);
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
    client.write(typing);
    typing = "";
  } else {
    typing = typing + key;
  }
}
