import 'dart:convert';

class MessagesModel {
  MessagesModel({
    this.from,
    this.to,
    this.message,
    this.createdAt,
    this.updatedAt,
  });

  final String from;
  final String to;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory MessagesModel.fromJson(Map<String, dynamic> json) => MessagesModel(
    from: json["from"],
    to: json["to"],
    message: json["message"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "from": from,
    "to": to,
    "message": message,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

MessagesModel messagesModelFromJson(String str) => MessagesModel.fromJson(json.decode(str));
String messagesModelToJson(MessagesModel data) => json.encode(data.toJson());