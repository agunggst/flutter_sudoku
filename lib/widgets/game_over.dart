import 'package:flutter/material.dart';
import 'package:flutter_sudoku/core/overlay_manager.dart';
import 'package:flutter_sudoku/pages/home.dart';
import 'package:flutter_sudoku/widgets/push_button.dart';

class GameOver extends StatelessWidget {
  const GameOver({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/gameover_illustration.png'),
              width: 300,
            ),
            SizedBox(height: 28,),
            GoToHome()
          ],
        ),
      ),
    );
  }
}

class GoToHome extends StatefulWidget {
  const GoToHome({super.key});

  @override
  State<GoToHome> createState() => _GoToHomeState();
}

class _GoToHomeState extends State<GoToHome> {
  @override
  Widget build(BuildContext context) {
    return PushButton(
      text: "Kembali", 
      onPressed: () {
        OverlayManager().hideOverlay();
        Navigator.pop(
          context,
          MaterialPageRoute(builder: (context) => const HomePage())
        );
      }
    );
  }
}