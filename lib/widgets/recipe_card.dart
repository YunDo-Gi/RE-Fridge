import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:re_fridge/controllers/recipe_controller.dart';
import 'package:re_fridge/colors.dart';
import 'package:re_fridge/widgets/tag_chip.dart';
import 'package:re_fridge/widgets/tag_chip_fixed.dart';
import 'package:re_fridge/views/recipe_detail.dart';

class RecipeCard extends GetView<RecipeController> {
  final int index;
  RecipeCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const cardRadius = 12.0;

    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
        ),
        elevation: 2,
        child: Slidable(
          key: UniqueKey(),
          startActionPane: ActionPane(
            // width of action pane
            extentRatio: 0.25,
            // A motion is a widget used to control how the pane animates.
            motion: const ScrollMotion(),

            // All actions are defined in the children parameter.
            children: [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                  autoClose: true,
                  onPressed: toCart(),
                  backgroundColor: PRIMARY_COLOR,
                  foregroundColor: Colors.white,
                  icon: Icons.shopping_cart,
                  label: 'To Cart',
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(cardRadius),
                      bottomLeft: Radius.circular(cardRadius))),
            ],
          ),
          child: ListTile(
            title: Text(controller.foundRecipes[index].recipeName,
                style: TextStyle(
                  
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(54, 40, 34, 1))),
            subtitle: Wrap(
              spacing: 8.0,
              runSpacing: -4.0,
              children: [
                for (var ingredient
                    in controller.foundRecipes[index].ingredients)
                  TagChipFixed(ingredientName: ingredient)
              ],
            ),
            subtitleTextStyle: TextStyle(color: Colors.red, height: 1.8),
            contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            onTap: () {
               Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RecipeDetail(index: index)),
                  );
            },
          ),
        ));
  }

  toCart() {}
}
