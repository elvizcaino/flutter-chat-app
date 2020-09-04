import 'package:chat/widgets/custom_blue_botton.dart';
import 'package:flutter/material.dart';

import 'package:chat/widgets/logo.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/custom_input.dart';


class RegisterPage extends StatelessWidget {

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
                Logo(title: "Register"),
                _Form(),
                Labels(
                  title1: "¿Ya tienes una cuenta?",
                  title2: "Ingresa ahora!",
                  onTap: () => Navigator.pushReplacementNamed(context, "login")
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
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.perm_identity,
            hintText: "Nombre y apellido",
            textController: fullNameController,
          ),
          SizedBox(height: 10),
          CustomInput(
            icon: Icons.mail_outline,
            hintText: "Correo electrónico",
            keyboardType: TextInputType.emailAddress,
            textController: emailController,
          ),
          SizedBox(height: 10),
          CustomInput(
            icon: Icons.lock_outline,
            hintText: "Contraseña",
            textController: passwordController,
            isPassword: true,
          ),
          SizedBox(height: 10),
          CustomBlueBotton(
            text: "Registrarme",
            onPressed: () {
              print(emailController.text);
            },
          )
        ],
      ),
    );
  }
}


