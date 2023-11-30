import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:re_fridge/controllers/add_item_controller.dart';

class IngredientCard extends GetView<AddItemController> {
  final int index;
  IngredientCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Card(
            child: InkWell(
          onTap: () {
            controller.addIngredient(index);
          },
          child: SizedBox(
              width: 50,
              height: 50,
              child: Center(
                child: Ink.image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        controller.foundIngredients[index].icon),
                    width: 30,
                    height: 30),
              )),
        )),
        Text(controller.foundIngredients[index].name, style: TextStyle(fontWeight: FontWeight.w500))
      ]),
    );
  }
}
