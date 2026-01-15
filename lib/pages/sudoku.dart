import 'package:flutter/material.dart';

class SudokuGamePage extends StatelessWidget {
  const SudokuGamePage({super.key});

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
          padding: EdgeInsetsGeometry.all(16),
          child: Center(
            child: Column(
              children: [
                const Text("Hello this is sudoku")
              ],
            ),
          ),
        )
      ),
    );
  }
}