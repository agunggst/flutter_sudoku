import 'package:flutter/material.dart';

class NumberTiles extends StatefulWidget {
  final String text;
  final bool isActive;
  final bool isClue;
  final bool isWrong;
  final List<int> coordinate;
  final Function(List<int> coordinate, bool isClue) onTilesTap;

  const NumberTiles({
    super.key,
    required this.text,
    required this.coordinate,
    required this.onTilesTap,
    this.isClue = false,
    this.isActive = false,
    this.isWrong = false
  });

  @override
  State<NumberTiles> createState() => _NumberTilesState();
}

class _NumberTilesState extends State<NumberTiles> {
  int tileColor = 0xFFFEEE91;
  int isClueTileColor = 0xFFF1E100;
  int isActiveTileColor = 0xFFA6F1E0;
  int isWrongTileColor = 0xFFF7CFD8;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTilesTap(widget.coordinate, widget.isClue);
      },
      child: Container(
        alignment: Alignment.center,
        width: 35,
        height: 35,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Color(
            widget.isWrong ? isWrongTileColor :
            widget.isActive ? isActiveTileColor :
            widget.isClue ? isClueTileColor : tileColor
          ),
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
      )
    );
    
  }
}