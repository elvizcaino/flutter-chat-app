import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/services/socket_service.dart';
import 'package:chat/helpers/show_alert.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/widgets/custom_blue_botton.dart';
import 'package:chat/widgets/logo.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/custom_input.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(title: "Messenger",),
                _Form(),
                Labels(
                  title1: "¿No tienes cuenta?",
                  title2: "Crea una ahora!",
                  onTap: () => Navigator.pushReplacementNamed(context, "register")
                ),
                Text("Términos y condiciones de uso", style: TextStyle(fontWeight: FontWeight.w200))
              ],
            ),
          ),
        ),
      )
   );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            hintText: "Correo electrónico",
            keyboardType: TextInputType.emailAddress,
            textController: emailController,
          ),
          SizedBox(height: 20),
          CustomInput(
            icon: Icons.lock_outline,
            hintText: "Contraseña",
            textController: passwordController,
            isPassword: true,
          ),
          SizedBox(height: 20),
          CustomBlueBotton(
            text: "Iniciar sesión",
            onPressed: authService.authenticating ? null : () async {
              FocusScope.of(context).unfocus();

              final isLoginOK = await authService.login(
                email: emailController.text.trim().toLowerCase(), 
                password: passwordController.text.trim()
              );

              if(isLoginOK) {
                socketService.connect();
                
                Navigator.pushReplacementNamed(context, "users");
              } else {
                showAlert(
                  context: context, 
                  title: "Login incorrecto", 
                  subtitle: "Login incorrecto, revise sus credenciales"
                );
              }
            },
          )
        ],
      ),
    );
  }
}


