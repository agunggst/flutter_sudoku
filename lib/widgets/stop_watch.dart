import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_sudoku/helper/convert_2_digits.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key,});

  @override
  State<StopWatch> createState() => StopWatchState();
}

class StopWatchState extends State<StopWatch> {
  Timer? _timer;
  int minute = 0;
  int second = 0;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer.periodic(
      const Duration(seconds: 1), 
      (Timer timer) {
        setState(() {
          if (isPaused == false) {
            if (second >= 59) {
              minute++;
              second = 0;
            } else {
              second++;
            }
          }
        });
      }
    );
  }

  void pauseTimer() {
    setState(() {
      isPaused = true;
    });
  }

  void continueTimer() {
    setState(() {
      isPaused = false;
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(12),
      child: Text(
        "${convert2Digits(minute)} : ${convert2Digits(second)}",
        style: TextStyle(
          fontFamily: "Cartoon",
          fontSize: 32,
          color: Colors.black54
        ),
      ),
    );
  }
}