import 'package:flutter/material.dart';
import 'package:flutter_sudoku/widgets/push_button.dart';
import 'package:flutter_sudoku/widgets/stop_watch.dart';
// import 'package:flutter_sudoku/widgets/number_tiles.dart';

class SudokuGamePage extends StatefulWidget {
  const SudokuGamePage({super.key});

  @override
  State<SudokuGamePage> createState() => _SudokuGamePageState();
}

class _SudokuGamePageState extends State<SudokuGamePage> {
  final GlobalKey<StopWatchState> stopwatchKey = GlobalKey<StopWatchState>();
  bool get isPaused => stopwatchKey.currentState?.isPaused ?? false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFA239),
        shadowColor: Colors.black54,
        toolbarHeight: 100,
        elevation: 8,
        title: Image(
          image: AssetImage('assets/flutter_sudoku_logo.png'),
          width: 160,
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(16),
          child: Center(
            child: Column(
              children: [
                // StopWatch(key: stopwatchKey,)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    StopWatch(key: stopwatchKey,),
                    PushButton(
                      text: isPaused ? "▶" : "⏸",
                      paddingH: 8,
                      paddingV: 4,
                      fontSize: 12,
                      onPressed: () {
                        setState(() {
                          if (isPaused) {
                            stopwatchKey.currentState?.continueTimer();
                          } else {
                            stopwatchKey.currentState?.pauseTimer();
                          }
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}