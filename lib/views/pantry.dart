import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:re_fridge/controllers/pantry_controller.dart';

class Pantry extends StatelessWidget {
  Pantry({Key? key}) : super(key: key);
  final pantryController = Get.put(PantryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GetX<PantryController>(
              builder: (controller) {
                return ListView.builder(
                  itemCount: controller.ingredients.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Icon(Icons.food_bank),
                        title: Text(controller.ingredients[index].ingredientName),
                        subtitle: Text(controller.ingredients[index].expiryDate.toString()),
                        subtitleTextStyle: TextStyle(color: Colors.red),
                        trailing: Text(controller.ingredients[index].quantity.toString()),
                        contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
