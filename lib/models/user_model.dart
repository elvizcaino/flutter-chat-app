// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

class UserModel {
  UserModel({
    this.online,
    this.fullName,
    this.email,
    this.uid,
  });

  bool online;
  String fullName;
  String email;
  String uid;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    online: json["online"],
    fullName: json["fullName"],
    email: json["email"],
    uid: json["uid"],
  );

  Map<String, dynamic> toJson() => {
    "online": online,
    "fullName": fullName,
    "email": email,
    "uid": uid,
  };
}

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));
String userModelToJson(UserModel data) => json.encode(data.toJson());