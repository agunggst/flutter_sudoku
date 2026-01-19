import 'package:flutter/material.dart';
import 'package:flutter_sudoku/pages/how_to_play.dart';
import 'package:flutter_sudoku/pages/sudoku.dart';
import 'package:flutter_sudoku/widgets/push_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage('assets/flutter_sudoku_logo_full.png'),
                  width: 300,
                ),
                const SizedBox(height: 20,),
                PushButton(
                  text: "MULAI", 
                  // fontFamily: "Cartoon",
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const SudokuGamePage())
                    );
                  }
                ),
                const SizedBox(height: 20,),
                PushButton(
                  text: "Panduan Bermain", 
                  // fontFamily: "Cartoon",
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const HowToPlayPage())
                    );
                  }
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}