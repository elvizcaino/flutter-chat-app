import "dart:io";
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

showAlert({@required BuildContext context, @required String title, @required String subtitle}) {
  if(Platform.isIOS) {
    return showCupertinoDialog(
      context: context, 
      builder: (_) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(subtitle),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text("Ok"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      )
    );
  }

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(subtitle),
      actions: [
        MaterialButton(
          child: Text("Ok"),
          elevation: 5,
          textColor: Colors.blue,
          onPressed: () => Navigator.pop(context),
        )
      ],
    )
  );
}