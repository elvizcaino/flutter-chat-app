// To parse this JSON data, do
//
//     final usersResponseModel = usersResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:chat/models/user_model.dart';


class UsersResponseModel {
   bool ok;
  List<UserModel> users;

  UsersResponseModel({
    this.ok,
    this.users,
  });

  factory UsersResponseModel.fromJson(Map<String, dynamic> json) => UsersResponseModel(
    ok: json["ok"],
    users: List<UserModel>.from(json["users"].map((x) => UserModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "users": List<dynamic>.from(users.map((x) => x.toJson())),
  };
}

UsersResponseModel usersResponseModelFromJson(String str) => UsersResponseModel.fromJson(json.decode(str));
String usersResponseModelToJson(UsersResponseModel data) => json.encode(data.toJson());