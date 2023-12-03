import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:re_fridge/colors.dart';

import 'package:re_fridge/controllers/recipe_controller.dart';
import 'package:re_fridge/widgets/add_recipe_dialog.dart';
import 'package:re_fridge/widgets/recipe_card.dart';

class Recipe extends StatelessWidget {
  final recipeController = Get.put(RecipeController());

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
        title: Text('My Recipe',
            style: TextStyle(
                color: Color.fromRGBO(54, 40, 34, 1),
                fontWeight: FontWeight.w700,
                fontSize: 30)),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline_rounded),
            color: Color.fromRGBO(54, 40, 34, 1),
            onPressed: () {
              showDialog(
                barrierColor: Color.fromRGBO(54, 40, 34, 0.7),
                barrierDismissible: true,
                context: context,
                builder: (BuildContext context) {
                  return AddRecipeDialog();
                },
              );
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
              child: TextField(
                cursorColor: PRIMARY_COLOR,
                onChanged: (value) {
                  recipeController.filterRecipe(value);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  suffixIcon: Icon(Icons.search,
                      color: Color.fromRGBO(54, 40, 34, 0.3)),
                  hintText: "Search..",
                  hintStyle: TextStyle(
                      color: Color.fromRGBO(54, 40, 34, 0.3),
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                  filled: true,
                  fillColor: Color.fromRGBO(54, 40, 34, 0.1),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
              ),
            ),
            Expanded(child: GetX<RecipeController>(builder: (controller) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                child: ListView.builder(
                  itemCount: recipeController.foundRecipes.length,
                  itemBuilder: (context, index) {
                    return RecipeCard(index: index);
                  },
                ),
              );
            }))
          ],
        ),
      ),
    );
  }
}
