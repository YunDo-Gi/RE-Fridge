import 'package:flutter/material.dart';

import 'package:re_fridge/colors.dart';

class NavigationBarBottom extends StatefulWidget {
  const NavigationBarBottom({Key? key}) : super(key: key);

  @override
  _NavigationBarBottomState createState() => _NavigationBarBottomState();
}

class _NavigationBarBottomState extends State<NavigationBarBottom> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
      currentIndex: _currentIndex,
      selectedItemColor: PRIMARY_COLOR,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      onTap: _onItemTapped,
    );
  }
}
