import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  final String title = 'Cart';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text('Cart'),
      ),
    );
  }
}
