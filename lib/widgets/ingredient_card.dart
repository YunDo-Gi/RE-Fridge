import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import 'package:re_fridge/controllers/ingredient_controller.dart';

class IngredientCard extends GetView<IngredientController> {
  const IngredientCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [Card(
        child: SizedBox(
          width: 100,
          height: 100,
          child: Center(child: Icon(Icons.food_bank)),
        ),
      ), Text('test')]),
    );
  }
}