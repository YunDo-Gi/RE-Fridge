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
      child: Column(children: [
        Card(
            child: InkWell(
          onTap: () {
            controller.addedIngredients.add(controller.foundIngredients[index]);
            print(controller.addedIngredients.length);
          },
          child: SizedBox(
              width: 50,
              height: 50,
              child: Center(
                child: Ink.image(
                    fit: BoxFit.cover,
                    image: const NetworkImage(
                        'https://cdn-icons-png.flaticon.com/128/2224/2224115.png'),
                    width: 30,
                    height: 30),
              )),
        )),
        Text('test')
      ]),
    );
  }
}
