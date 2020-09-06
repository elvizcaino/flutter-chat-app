import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/services/socket_service.dart';
import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/users_page.dart';
import 'package:chat/services/auth_service.dart';


class LoadingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text('Verificando...'),
          );
        },
      ),
   );
  }

  Future checkLoginState(BuildContext context) async {
    final socketService = Provider.of<SocketService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
    final authenticated = await authService.isLoggedIn();
    
    if(authenticated) {
      socketService.connect();
      Navigator.pushReplacement(context, PageRouteBuilder(
        pageBuilder: (_, __, ___) => UsersPage(),
        transitionDuration: Duration(milliseconds: 0)
      ));
    } else {
      Navigator.pushReplacement(context, PageRouteBuilder(
        pageBuilder: (_, __, ___) => LoginPage(),
        transitionDuration: Duration(milliseconds: 0)
      ));
    }
  }
}