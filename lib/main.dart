import 'package:flutter/material.dart';
import 'views/pantry.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "RE:Fridge",
      theme: ThemeData(
        fontFamily: 'Tisa',
      ),
      home: Pantry(),
    );
  }
}
