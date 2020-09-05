import 'dart:io';

class Enviroment {
  static String apiURL = Platform.isIOS ? "http://localhost:3000/api" : "http://10.0.2.2:3000/api";
  static String socketURL = Platform.isIOS ? "http://localhost:3000" : "http://10.0.2.2:3000";
}