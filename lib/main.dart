import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'views/pantry.dart';
import 'views/app.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: FToastBuilder(),
      title: "RE:Fridge",
      theme: ThemeData(
        fontFamily: 'Tisa',
      ),
      home: App(),
    );
  }
}
