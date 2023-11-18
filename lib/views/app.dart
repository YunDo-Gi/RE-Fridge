import 'package:flutter/material.dart';

import 'package:re_fridge/views/pantry.dart';
import 'package:re_fridge/views/recommended_recipe.dart';
import 'package:re_fridge/views/recipe.dart';
import 'package:re_fridge/views/cart.dart';

import 'package:re_fridge/colors.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<App> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    Pantry(),
    RecommendedRecipe(),
    Recipe(),
    Cart()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Pantry',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.recommend_outlined), label: 'Recommend'),
            BottomNavigationBarItem(
                icon: Icon(Icons.book_outlined), label: 'Recipe'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: PRIMARY_COLOR,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          onTap: _onItemTapped,
        ));
  }
}
