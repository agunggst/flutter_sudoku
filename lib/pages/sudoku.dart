import 'package:flutter/material.dart';
import 'package:flutter_sudoku/functions/generate_sudoku_board.dart';
import 'package:flutter_sudoku/widgets/modals/simple_dialog.dart';
import 'package:flutter_sudoku/widgets/number_tiles.dart';
import 'package:flutter_sudoku/widgets/numpad.dart';
import 'package:flutter_sudoku/widgets/push_button.dart';
import 'package:flutter_sudoku/widgets/stop_watch.dart';

class SudokuGamePage extends StatefulWidget {
  const SudokuGamePage({super.key});

  @override
  State<SudokuGamePage> createState() => _SudokuGamePageState();
}

class _SudokuGamePageState extends State<SudokuGamePage> {
  List<List<int>> sudokuBoard = [];
  List<List<int>> sudokuBoardCopy = [];
  bool isShowNumpad = false;
  List<int>? activeCell;
  final GlobalKey<StopWatchState> stopwatchKey = GlobalKey<StopWatchState>();
  bool get isPaused => stopwatchKey.currentState?.isPaused ?? false;

  @override
  void initState() {
    super.initState();
    sudokuBoard = generateSudokuByDifficulty('medium');
    sudokuBoardCopy = sudokuBoard.map((row) => [...row]).toList();
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        bool? exit = await showConfirmDialog(
          context: context, 
          title: "Perhatian!", 
          message: "Apakah kamu ingin keluar dari game?",
        );

        if (exit == true && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
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
                    ],
                  ),
                  const SizedBox(height: 32,),
                  Column(
                    children: List.generate(9, (row) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(9, (col) {
                          return Row(
                            children: [
                              Column(
                                children: [
                                  NumberTiles(
                                    text: sudokuBoard[row][col].toString(),
                                    isClue: sudokuBoardCopy[row][col] == 0 ? false : true,
                                    coordinate: [row, col],
                                    isActive: activeCell != null &&
                                              activeCell![0] == row &&
                                              activeCell![1] == col,
                                    onTilesTap: (coordinate, isClue) {
                                      if (!isClue) {
                                        setState(() {
                                          activeCell = coordinate;
                                          isShowNumpad = true;
                                        });
                                      }
                                    }
                                  ),
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
                  const SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PushButton(
                        text: "Reset", 
                        paddingH: 28,
                        paddingV: 8,
                        fontSize: 16,
                        onPressed: () {
                          setState(() {
                            sudokuBoard = sudokuBoardCopy.map((row) => [...row]).toList();
                          });
                        }
                      ),
                      const SizedBox(width: 8,),
                      PushButton(
                        text: "Submit", 
                        paddingH: 28,
                        paddingV: 8,
                        fontSize: 16,
                        onPressed: () {}
                      ),
                    ],
                  ),
                  const SizedBox(height: 28,),
                  if (isShowNumpad)
                    Container(
                      width: 100,
                      // height: ,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          NumPad(
                            onNumpadPressed: (number) {
                              // print("Angka: $number masukkan ke tile $activeCell");
                              setState(() {
                                sudokuBoard[activeCell![0]][activeCell![1]] = number;
                                isShowNumpad = false;
                                activeCell = null;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
          )
        ),
      )
    );
  }
}