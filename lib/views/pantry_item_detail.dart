import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import 'package:re_fridge/colors.dart';
import 'package:re_fridge/controllers/pantry_controller.dart';
import 'package:re_fridge/controllers/recipe_controller.dart';
import 'package:re_fridge/widgets/custom_divider.dart';
import 'package:re_fridge/widgets/pantry_match_recipe_card.dart';

class PantryItemDetail extends GetView<PantryController> {
  final int index;
  PantryItemDetail({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBar(
        iconTheme: IconThemeData(
          // back button color
          color: TEXT_COLOR,
        ),
        backgroundColor: Colors.white,
        notificationPredicate: (ScrollNotification notification) {
          return notification.depth == 1;
        },
        scrolledUnderElevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.edit_outlined),
            color: TEXT_COLOR,
            onPressed: () {
              // open edit dialog
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart_checkout_outlined),
            color: TEXT_COLOR,
            onPressed: () {
              // add to cart
            },
          ),
          IconButton(
            icon: Icon(Icons.delete_outline_rounded),
            color: TEXT_COLOR,
            onPressed: () {
              // delete item
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: Container(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Text(
                      controller.foundIngredients[index].ingredientName,
                      style: TextStyle(
                          color: Color.fromRGBO(54, 40, 34, 1),
                          fontWeight: FontWeight.w700,
                          fontSize: 30),
                    ),
                  ),
                  // Pantry Item Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Category
                      Padding(
                        padding: EdgeInsets.only(right: 24.0),
                        child: Row(
                          children: [
                            CustomDivider(paddingRight: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Category',
                                  style: TextStyle(
                                      color: TEXT_COLOR.withOpacity(0.5),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12),
                                ),
                                Text(
                                  controller.foundIngredients[index].category,
                                  style: TextStyle(
                                      color: controller.getCategoryColor(
                                          controller.foundIngredients[index]
                                              .category),
                                      fontFamily: 'Baloo2',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Expiry Date
                      Padding(
                        padding: EdgeInsets.only(right: 24.0),
                        child: Row(
                          children: [
                            CustomDivider(paddingRight: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Expiry Date',
                                  style: TextStyle(
                                      color: TEXT_COLOR.withOpacity(0.5),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12),
                                ),
                                Text(
                                  controller.foundIngredients[index].expiryDate
                                      .toString()
                                      .substring(0, 10),
                                  style: TextStyle(
                                      color: controller.getExperationDateColor(
                                          controller.foundIngredients[index]
                                              .expiryDate),
                                      fontFamily: 'Baloo2',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Quantity
                      Padding(
                        padding: EdgeInsets.only(right: 24.0),
                        child: Row(
                          children: [
                            CustomDivider(paddingRight: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Quantity',
                                  style: TextStyle(
                                      color: TEXT_COLOR.withOpacity(0.5),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12),
                                ),
                                Text(
                                  '${controller.foundIngredients[index].quantity}' +
                                      ' EA',
                                  style: TextStyle(
                                      color: TEXT_COLOR,
                                      fontFamily: 'Baloo2',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 0),
            child: Text(
              'Recipes with ${controller.foundIngredients[index].ingredientName}',
              style: TextStyle(
                color: TEXT_COLOR.withOpacity(0.5),
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(child: GetX<RecipeController>(builder: (controller) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
              child: ListView.builder(
                itemCount: controller
                    .getAvailableRecipeByIngredient(
                        this.controller.foundIngredients[index].ingredientName)
                    .length,
                itemBuilder: (context, index) {
                  return PantryMatchRecipeCard(index: index);
                },
              ),
            );
          }))
        ],
      ),
    );
  }
}
