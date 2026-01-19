import 'package:flutter/material.dart';
import 'package:flutter_sudoku/core/overlay_manager.dart';
import 'package:flutter_sudoku/functions/generate_sudoku_board.dart';
import 'package:flutter_sudoku/functions/is_sudoku_filled.dart';
import 'package:flutter_sudoku/functions/validate_sudoku_board.dart';
import 'package:flutter_sudoku/widgets/game_over.dart';
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
  bool canSubmit = false;
  List<int>? activeCell;
  final GlobalKey<StopWatchState> stopwatchKey = GlobalKey<StopWatchState>();
  bool get isPaused => stopwatchKey.currentState?.isPaused ?? false;
  String errorText = "Silahkan lengkapi sudoku terlebih dahulu";

  @override
  void initState() {
    super.initState();
    sudokuBoard = generateSudokuByDifficulty('easy');
    sudokuBoardCopy = sudokuBoard.map((row) => [...row]).toList();
  }

  void gameOver() {
    setState(() {
      stopwatchKey.currentState?.pauseTimer();
      isShowNumpad = false;
      OverlayManager().showOverlay(
        context,
        GameOver()
      );
    });
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
          toolbarHeight: 80,
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
                              isShowNumpad = false;
                              activeCell = null;
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
                                      if (!isClue && !isPaused) {
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
                        text: "Ulangi", 
                        paddingH: 28,
                        paddingV: 8,
                        fontSize: 16,
                        onPressed: () {
                          setState(() {
                            sudokuBoard = sudokuBoardCopy.map((row) => [...row]).toList();
                            canSubmit = false;
                            isShowNumpad = false;
                            activeCell = null;
                          });
                        }
                      ),
                      const SizedBox(width: 8,),
                      PushButton(
                        text: "Periksa", 
                        paddingH: 28,
                        paddingV: 8,
                        fontSize: 16,
                        onPressed: () {
                          bool checkResult = validateSudokuBoard(sudokuBoard);
                          print(checkResult);
                          if (checkResult) {
                            gameOver();
                          } else {
                            setState(() {
                              errorText = "Masih ada yang salah... Coba lagi";
                              canSubmit = false;
                            });
                          }
                        },
                        enabled: canSubmit,
                      ),
                    ],
                  ),
                  if (!canSubmit)
                    const SizedBox(height: 12,),
                  if (!canSubmit)
                    Text(
                      errorText,
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontFamily: "Cartoon"
                      ),
                    ),
                  const SizedBox(height: 16,),
                  if (isShowNumpad)
                    Container(
                      width: 100,
                      // height: ,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          NumPad(
                            onNumpadPressed: (number) {
                              setState(() {
                                sudokuBoard[activeCell![0]][activeCell![1]] = number;
                                // CHEAT!!
                                // List<List<int>> solvedBoard = [
                                //   [4, 1, 2, 6, 5, 9, 3, 8, 7],
                                //   [3, 5, 6, 2, 7, 8, 9, 1, 4],
                                //   [9, 8, 7, 3, 1, 4, 5, 6, 2],

                                //   [1, 9, 5, 8, 4, 3, 2, 7, 6],
                                //   [7, 6, 3, 5, 2, 1, 8, 4, 9],
                                //   [8, 2, 4, 7, 9, 6, 1, 3, 5],

                                //   [2, 7, 8, 1, 6, 5, 4, 9, 3],
                                //   [6, 3, 9, 4, 8, 2, 7, 5, 1],
                                //   [5, 4, 1, 9, 3, 7, 6, 2, 8],
                                // ];
                                // sudokuBoard = solvedBoard;

                                canSubmit = isSudokuFilled(sudokuBoard);
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