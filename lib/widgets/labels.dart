import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final GestureTapCallback onTap;
  final String title1;
  final String title2;

  const Labels({
    Key key, 
    @required this.onTap,
    @required this.title1,
    @required this.title2
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(this.title1, style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300)),
          SizedBox(height: 10),
          GestureDetector(
            child: Text(this.title2, style: TextStyle(color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold)),
            onTap: this.onTap,
          ),
        ],
      ),
    );
  }
}