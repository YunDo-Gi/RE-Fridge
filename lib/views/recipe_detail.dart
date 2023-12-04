import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:re_fridge/colors.dart';
import 'package:re_fridge/controllers/recipe_controller.dart';

class RecipeDetail extends GetView<RecipeController> {
  final int index;
  RecipeDetail({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(245, 236, 220, 1),
        appBar: AppBar(
          iconTheme: IconThemeData(
              // back button color
              color: TEXT_COLOR, 
            ),
          backgroundColor: Colors.white,
          centerTitle: false,
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },
          scrolledUnderElevation: 0.0,
          title: Text(controller.foundRecipes[index].recipeName,
              style: TextStyle(
                  color: Color.fromRGBO(54, 40, 34, 1),
                  fontWeight: FontWeight.w700,
                  fontSize: 30)),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
          child: Text('sth'),
        ));
  }
}
