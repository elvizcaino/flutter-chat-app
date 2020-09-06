import 'package:chat/models/messages_model.dart';
import 'package:chat/models/messages_response_model.dart';
import 'package:chat/services/auth_service.dart';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';

import 'package:chat/global/environment.dart';
import 'package:chat/models/user_model.dart';

class ChatService with ChangeNotifier {
  UserModel userTo;

  Future<List<MessagesModel>> getChat(String uid) async {
    final res = await http.get("${Enviroment.apiURL}/messages/$uid",
      headers: {
        "Content-Type": "application/json",
        "x-token": await AuthService.getToken()
      }
    );

    final messagesResponse = messagesResponseModelFromJson(res.body);

    return messagesResponse.messages;
  }
}