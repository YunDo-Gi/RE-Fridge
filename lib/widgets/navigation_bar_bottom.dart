import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:re_fridge/colors.dart';
import 'package:re_fridge/controllers/navigation_bar_controller.dart';

class NavigationBarBottom extends StatelessWidget {
  NavigationBarBottom({Key? key}) : super(key: key);
  final NavigationBarController navigationBarController =
      Get.put(NavigationBarController());

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
      currentIndex: Get.find<NavigationBarController>().currentIndex,
      selectedItemColor: PRIMARY_COLOR,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      onTap: (index) {
        Get.find<NavigationBarController>().changeIndex(index);
      },
    );
  }
}