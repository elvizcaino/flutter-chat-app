import 'dart:convert';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat/models/user_model.dart';
import 'package:chat/models/login_response_model.dart';
import "../global/environment.dart";

class AuthService with ChangeNotifier {
  UserModel user;
  bool _authenticating = false;
  final _storage = FlutterSecureStorage();

  bool get authenticating => this._authenticating;

  set authenticating(bool value) {
    this._authenticating = value;
    notifyListeners();
  }

  static Future<String> getToken() async {
    final storage = FlutterSecureStorage();

    return await storage.read(key: "token");
  }

  static Future<void> deleteToken() async {
    final storage = FlutterSecureStorage();

    await storage.delete(key: "token");
  }

  Future<bool> login({String email, String password}) async {
    this.authenticating = true;

    final data = {
      "email": email,
      "password": password
    };

    final res = await http.post("${Enviroment.apiURL}/login",
      body: jsonEncode(data),
      headers: {
        "Content-Type": "application/json"
      }
    );

    if(res.statusCode == 200) {
      final loginResponse = loginResponseModelFromJson(res.body);

      this.user = loginResponse.user;
      await this._saveToken(loginResponse.token);

      this.authenticating = false;
      return true;
    } else {
      this.authenticating = false;
      return false;
    }
  }

  Future register({@required String fullName, @required String email, @required String password}) async {
    //this.authenticating = true;

    final data = {
      "fullName": fullName,
      "email": email,
      "password": password
    };

    final res = await http.post("${Enviroment.apiURL}/login/new",
      body: jsonEncode(data),
      headers: {
        "Content-Type": "application/json"
      }
    );

    if(res.statusCode == 200) {
      final loginResponse = loginResponseModelFromJson(res.body);

      this.user = loginResponse.user;
      await this._saveToken(loginResponse.token);

      this.authenticating = false;
      
      return true;
    } else {
      final resBody = jsonDecode(res.body);
      
      this.authenticating = false;
      return resBody["msg"];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: "token");

    final res = await http.get("${Enviroment.apiURL}/login/renew",
      headers: {
        "Content-Type": "application/json",
        "x-token": token
      }
    );

    if(res.statusCode == 200) {
      final loginResponse = loginResponseModelFromJson(res.body);

      this.user = loginResponse.user;
      await this._saveToken(loginResponse.token);
      
      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: "token", value: token);
  }

  Future logout() async {
    await _storage.delete(key: "token");
  }

}