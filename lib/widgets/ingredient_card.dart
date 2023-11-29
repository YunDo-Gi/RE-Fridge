import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import 'package:re_fridge/controllers/add_item_controller.dart';

class IngredientCard extends GetView<AddItemController> {
  final int index;
  IngredientCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [Card(
        child: SizedBox(
          width: 50,
          height: 50,
          child: Center(child: Tab(icon: Container(
          child: Image(
            image: AssetImage(
              'assets/icons/carrot.png',
            ),
            fit: BoxFit.cover,
          ),
          height: 50,
          width: 50,
        ),)),
        ),
      ), Text('test')]),
    );
  }
}