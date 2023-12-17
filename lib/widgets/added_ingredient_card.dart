import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:re_fridge/controllers/add_item_controller.dart';
import 'package:re_fridge/colors.dart';

class AddedIngredientCard extends GetView<AddItemController> {
  final int index;
  AddedIngredientCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: Card(
            child: SizedBox(
                width: 50,
                height: 50,
                child: Center(
                  child: Image(
                      fit: BoxFit.cover,
                      image:
                          NetworkImage(controller.addedIngredients[index].icon),
                      width: 30,
                      height: 30),
                )),
          ),
        ),
        Positioned(
          top: -13,
          right: -9,
          child: IconButton(
            iconSize: 20.0,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            color: RED_COLOR,
            icon: Icon(Icons.cancel),
            onPressed: () {
              controller.removeIngredient(index);
            },
          ),
        )
      ],
    );
  }
}
