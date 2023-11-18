import 'package:flutter/material.dart';

class RecommendedRecipe extends StatelessWidget {
  final String title = 'RecommendedRecipe';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text('RecommendedRecipe'),
      ),
    );
  }
}
