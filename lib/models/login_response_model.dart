import 'dart:convert';

import 'package:chat/models/user_model.dart';

class LoginResponseModel {
    LoginResponseModel({
        this.ok,
        this.user,
        this.token,
    });

    bool ok;
    UserModel user;
    String token;

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        ok: json["ok"],
        user: UserModel.fromJson(json["user"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "user": user.toJson(),
        "token": token,
    };
}

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));
String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());