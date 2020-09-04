import 'package:flutter/material.dart';

class CustomBlueBotton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomBlueBotton({
    Key key, 
    @required this.onPressed, 
    @required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 2,
      hoverElevation: 5,
      color: Colors.blue,
      shape: StadiumBorder(),
      onPressed: this.onPressed,
      child: Container(
        width: double.infinity,
        height: 50,
        child: Center(
          child: Text(this.text, style: TextStyle(color: Colors.white, fontSize: 17))
        )
      ),
    );
  }
}