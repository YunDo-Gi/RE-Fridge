import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

import 'package:re_fridge/controllers/pantry_controller.dart';

class PantryItem extends StatefulWidget {
  final int index;
  const PantryItem({Key? key, required this.index}) : super(key: key);
  

  @override
  _PantryItemState createState() => _PantryItemState();
}

class _PantryItemState extends State<PantryItem> {
  final controller = Get.put(PantryController());
  int get index => widget.index;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:
          EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 0),
      elevation: 2,
      child: ListTile(
        leading: Icon(
          Icons.food_bank,
          size: 36,
        ),
        title: Text(
            controller.foundIngredients[index]
                .ingredientName,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(
                    54, 40, 34, 1))),
        subtitle: controller.toDDay(controller
            .foundIngredients[index].expiryDate),
        subtitleTextStyle: TextStyle(
            color: Colors.red, height: 1.5),
        trailing: Text(
            controller.foundIngredients[index]
                    .quantity
                    .toString() +
                ' g',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(
                    54, 40, 34, 1))),
        contentPadding:
            EdgeInsets.fromLTRB(20, 0, 20, 0),
      ),
    );
  }
}