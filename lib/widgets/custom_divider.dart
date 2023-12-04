import 'package:flutter/material.dart';

Widget CustomDivider({required double paddingRight}) {
  return Padding(
  padding: EdgeInsets.only(right: paddingRight),
  child: Container(
    height: 40,
    width: 1,
    color: Color.fromRGBO(54, 40, 34, 0.2),
  ),
);
}


