import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:re_fridge/controllers/recommended_recipe_controller.dart';
import 'package:re_fridge/widgets/recommended_recipe_card.dart';

class RecommendedRecipe extends StatelessWidget {
  final String title = 'RecommendedRecipe';
  final recommendedRecipeController = Get.put(RecommendedRecipeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 236, 220, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        notificationPredicate: (ScrollNotification notification) {
          return notification.depth == 1;
        },
        scrolledUnderElevation: 0.0,
        title: Text('Recommended Recipe',
            style: TextStyle(
                color: Color.fromRGBO(54, 40, 34, 1),
                fontWeight: FontWeight.w700,
                fontSize: 30)),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
        child: ListView.builder(
          itemCount: recommendedRecipeController.recipes.length,
          itemBuilder: (context, index) {
            return RecommendedRecipeCard(index: index);
          },
        ),
      ),
    );
  }
}
