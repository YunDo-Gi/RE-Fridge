import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:re_fridge/colors.dart';

import 'package:re_fridge/controllers/tag_controller.dart';
import 'package:re_fridge/controllers/add_item_controller.dart';

const categoryAvatar = [
  {
    'category': 'Vegetable',
    'icon': 'https://cdn-icons-png.flaticon.com/128/2553/2553701.png'
  },
  {
    'category': 'Meat',
    'icon': 'https://cdn-icons-png.flaticon.com/128/2224/2224259.png'
  },
  {
    'category': 'Fish',
    'icon': 'https://cdn-icons-png.flaticon.com/128/10507/10507711.png'
  },
  {
    'category': 'Seafood',
    'icon': 'https://cdn-icons-png.flaticon.com/128/1915/1915297.png'
  },
  {
    'category': 'Dairy',
    'icon': 'https://cdn-icons-png.flaticon.com/128/7295/7295454.png'
  },
  {
    'category': 'Egg',
    'icon': 'https://cdn-icons-png.flaticon.com/128/837/837560.png'
  }
];

class TagChipFixed extends GetView<TagController> {
  final String ingredientName;
  TagChipFixed({Key? key, required this.ingredientName}) : super(key: key);
  final addItemController = Get.put(AddItemController());

  @override
  Widget build(BuildContext context) {
    String category = addItemController.getCategoryfromIngredientName(ingredientName);

    return Chip(
          label: Text(ingredientName, style: TextStyle(fontFamily: 'Baloo2', fontWeight: FontWeight.w700, color: Colors.white)),
          backgroundColor: setColor(category),
          avatar: CircleAvatar(
            backgroundColor: Colors.white,
            child: Image.network(getAvatar(category), width: 18, height: 18))
          
        );
  }

  setColor(String category) {
    switch (category) {
      case 'Vegetable':
        return PRIMARY_COLOR;
      case 'Meat':
        return RED_COLOR;
      case 'Seafood' || 'Fish':
        return BLUE_COLOR;
      case 'Dairy' || 'Egg':
        return YELLOW_COLOR;
      default:
        return Colors.grey;
    }
  }

  getAvatar(String category) {
    for (var i = 0; i < categoryAvatar.length; i++) {
      if (categoryAvatar[i]['category'] == category) {
        return categoryAvatar[i]['icon'];
      }
    }
  }
}