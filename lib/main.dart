import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:re_fridge/colors.dart';

import 'views/app.dart';



void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: FToastBuilder(),
      title: "RE:Fridge",
      theme: ThemeData(
        primaryColor: PRIMARY_COLOR,
        fontFamily: 'Tisa',
      ),
      home: App(),
    );
  }
}
