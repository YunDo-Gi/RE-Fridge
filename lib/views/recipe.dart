import 'package:flutter/material.dart';

class Recipe extends StatelessWidget {
  final String title = 'Recipe';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text('Recipe'),
      ),
    );
  }
}
