import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sudoku/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Rufing',
        scaffoldBackgroundColor: Color(0xFF8CE4FF),
      ),
      home: const HomePage(),
    );
  }
}