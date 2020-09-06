import 'dart:convert';

import 'package:chat/models/messages_model.dart';

class MessagesResponseModel {
  MessagesResponseModel({
    this.ok,
    this.messages,
  });

  final bool ok;
  final List<MessagesModel> messages;

  factory MessagesResponseModel.fromJson(Map<String, dynamic> json) => MessagesResponseModel(
    ok: json["ok"],
    messages: List<MessagesModel>.from(json["messages"].map((x) => MessagesModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
  };
}

MessagesResponseModel messagesResponseModelFromJson(String str) => MessagesResponseModel.fromJson(json.decode(str));
String messagesResponseModelToJson(MessagesResponseModel data) => json.encode(data.toJson());