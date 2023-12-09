import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:re_fridge/colors.dart';

import 'package:re_fridge/controllers/tag_controller.dart';

class TagChip extends GetView<TagController> {
  final int index;
  TagChip({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
          label: Text(controller.tagsSelected[index].ingredientName, style: TextStyle(fontFamily: 'Baloo2', fontWeight: FontWeight.w700, color: Colors.white)),
          onDeleted: () {
            controller.deleteTag(index);
          },
          deleteIcon: Icon(Icons.close, color: Colors.white, size: 20),
          backgroundColor: setColor(controller.tagsSelected[index].category),
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
}