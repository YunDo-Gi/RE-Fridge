import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:re_fridge/controllers/recipe_controller.dart';
import 'package:re_fridge/colors.dart';
import 'package:re_fridge/widgets/tag_chip_fixed.dart';

class PantryMatchRecipeCard extends GetView<RecipeController> {
  final int index;
  PantryMatchRecipeCard({Key? key, required this.index}) : super(key: key);

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
            title: 
            Padding(padding: EdgeInsets.only(bottom: 8), 
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(controller.availableRecipes[index].recipeName,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(54, 40, 34, 1))),
                Container(
                  alignment: Alignment.center,
                  height: 26,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 1.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Color.fromRGBO(143, 180, 78, 0.2),
                  ),
                  child: Text(
                    controller.availableRecipes[index].fullfillCount.toString() +
                        ' / ' +
                        controller.availableRecipes[index].ingredients.length.toString(),
                    style: TextStyle(
                      fontFamily: 'Baloo2',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: PRIMARY_COLOR,
                    ),
                  ),
                ),
              ],
            ),),
            
            subtitle: Wrap(
              spacing: 8.0,
              runSpacing: -4.0,
              children: [
                for (var ingredient in controller.availableRecipes[index].ingredients)
                  TagChipFixed(ingredientName: ingredient)
              ],
            ),
            subtitleTextStyle: TextStyle(color: Colors.red, height: 1.8),
            contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          ),
        ));
  }

  toCart() {}
}
