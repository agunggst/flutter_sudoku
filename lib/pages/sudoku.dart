import 'package:flutter/material.dart';
import 'package:flutter_sudoku/functions/generate_sudoku_board.dart';
import 'package:flutter_sudoku/widgets/number_tiles.dart';
import 'package:flutter_sudoku/widgets/push_button.dart';
import 'package:flutter_sudoku/widgets/stop_watch.dart';
// import 'package:flutter_sudoku/widgets/number_tiles.dart';

class SudokuGamePage extends StatefulWidget {
  const SudokuGamePage({super.key});

  @override
  State<SudokuGamePage> createState() => _SudokuGamePageState();
}

class _SudokuGamePageState extends State<SudokuGamePage> {
  List<List<int>> sudokuBoard = [
    [6,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,4,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,7,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
  ];
  final GlobalKey<StopWatchState> stopwatchKey = GlobalKey<StopWatchState>();
  bool get isPaused => stopwatchKey.currentState?.isPaused ?? false;

  @override
  void initState() {
    super.initState();
    setState(() {
      sudokuBoard = generateSudokuByDifficulty('medium');
    });
  }

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
                    const SizedBox(height: 64,),
                  ],
                ),
                Column(
                  children: List.generate(9, (row) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(9, (col) {
                        return Row(
                          children: [
                            Column(
                              children: [
                                NumberTiles(text: sudokuBoard[row][col].toString()),
                                SizedBox(height: (row+1)%3 == 0 ? 8 : 0,)
                              ],
                            ),
                            SizedBox(width: (col+1)%3 == 0 && (col+1) != 9 ? 8 : 0,)
                          ],
                        );
                      }),
                    );
                  }),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}