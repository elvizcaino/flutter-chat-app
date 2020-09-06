import "package:http/http.dart" as http;

import 'package:chat/models/users_response_model.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/global/environment.dart';
import 'package:chat/models/user_model.dart';

class UsersService {
  Future<List<UserModel>> getUsers() async {
    try {
      final res = await http.get("${Enviroment.apiURL}/users",
        headers: {
          "Content-Type": "application/json",
          "x-token": await AuthService.getToken()
        }
      );

      final usersResponse = usersResponseModelFromJson(res.body);

      return usersResponse.users;
    } catch (error) {
      return [];
    }
  }
}