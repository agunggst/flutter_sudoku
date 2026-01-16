import 'package:flutter/material.dart';

class NumberTiles extends StatefulWidget {
  final String text;

  const NumberTiles({
    super.key,
    required this.text
  });

  @override
  State<NumberTiles> createState() => _NumberTilesState();
}

class _NumberTilesState extends State<NumberTiles> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 35,
      height: 35,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Color(0xFFFEEE91),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(9, 30, 66, 0.25),
            blurRadius: 8,
            spreadRadius: -2,
            offset: Offset(0, 4),
          ),
          BoxShadow(
            color: Color.fromRGBO(9, 30, 66, 0.08),
            blurRadius: 0,
            spreadRadius: 1,
            offset: Offset(0, 0),
          )
        ]
      ),
      child: Text(
        widget.text == "0" ? " " : widget.text,
        style: TextStyle(
          fontFamily: 'Cartoon'
        ),
      ),
    );
  }
}