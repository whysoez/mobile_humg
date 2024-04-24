import 'dart:html';

void main() {
  print("hello world");
  getDataFromDatabase();
}

void getDataFromDatabase(){
  print("start");
  Future.delayed(Duration(seconds: 3));
  print("end.");
}
