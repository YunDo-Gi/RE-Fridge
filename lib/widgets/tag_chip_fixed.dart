import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:re_fridge/colors.dart';

import 'package:re_fridge/controllers/tag_controller.dart';
import 'package:re_fridge/controllers/add_item_controller.dart';
import 'package:re_fridge/models/category_data.dart';

class TagChipFixed extends GetView<TagController> {
  final String ingredientName;
  TagChipFixed({Key? key, required this.ingredientName}) : super(key: key);
  final addItemController = Get.put(AddItemController());

  @override
  Widget build(BuildContext context) {
    String category = addItemController.getCategoryfromIngredientName(ingredientName);
    print(category);

    return Chip(
          label: Text(ingredientName, style: TextStyle(fontFamily: 'Baloo2', fontWeight: FontWeight.w700, color: Colors.white)),
          backgroundColor: setColor(category),
          avatar: CircleAvatar(
            backgroundColor: Colors.white,
            child: Image.network(getAvatar(category), width: 18, height: 18))
          
        );
  }

  setColor(String category) {
    switch (category.toLowerCase()) {
      case 'vegetable':
        return PRIMARY_COLOR;
      case 'meat':
        return RED_COLOR;
      case 'seafood' || 'fish':
        return BLUE_COLOR;
      case 'dairy' || 'egg':
        return YELLOW_COLOR;
      default:
        return Colors.grey;
    }
  }

  getAvatar(String category) {
    for (var i = 0; i < categoryAvatar.length - 1; i++) {
      if (categoryAvatar[i]['category'] == category) {
        return categoryAvatar[i]['icon'];
      }
    }
    return categoryAvatar[categoryAvatar.length - 1]['icon'];
  }
}