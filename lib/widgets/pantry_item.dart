import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:re_fridge/controllers/pantry_controller.dart';
import 'package:re_fridge/colors.dart';

class PantryItem extends StatefulWidget {
  final int index;
  const PantryItem({Key? key, required this.index}) : super(key: key);

  @override
  _PantryItemState createState() => _PantryItemState();
}

class _PantryItemState extends State<PantryItem> {
  final controller = Get.put(PantryController());
  int get index => widget.index;

  @override
  Widget build(BuildContext context) {
    const cardRadius = 12.0;

    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
        ),
        elevation: 2,
        child: Slidable(
          key: const ValueKey(0),
          startActionPane: ActionPane(
            // width of action pane
            extentRatio: 0.25,
            // A motion is a widget used to control how the pane animates.
            motion: const ScrollMotion(),

            // A pane can dismiss the Slidable.
            dismissible: DismissiblePane(onDismissed: () {
              
            }),

            // All actions are defined in the children parameter.
            children: [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                autoClose: true,
                onPressed: doNothing(),
                backgroundColor: PRIMARY_COLOR,
                foregroundColor: Colors.white,
                icon: Icons.shopping_cart,
                label: 'To Cart',
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(cardRadius),
                    bottomLeft: Radius.circular(cardRadius))
              ),
            ],
          ),
          child: ListTile(
            leading: Icon(
              Icons.food_bank,
              size: 36,
            ),
            title: Text(controller.foundIngredients[index].ingredientName,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(54, 40, 34, 1))),
            subtitle: controller
                .toDDay(controller.foundIngredients[index].expiryDate),
            subtitleTextStyle: TextStyle(color: Colors.red, height: 1.8),
            trailing: Text(
                controller.foundIngredients[index].quantity.toString() + ' g',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(54, 40, 34, 1))),
            contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          ),
          endActionPane: ActionPane(
            extentRatio: 0.25,
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(onDismissed: () {}),
            children: [
              SlidableAction(
                autoClose: true,
                onPressed: doNothing(),
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(cardRadius),
                    bottomRight: Radius.circular(cardRadius))
              ),
            ],
          ),
        ));
  }

  doNothing() {}

  deleteIngredient(ingredientId) {
    controller.deleteIngredient(ingredientId);
  }
}
