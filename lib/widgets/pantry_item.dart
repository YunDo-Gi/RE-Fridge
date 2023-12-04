import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:re_fridge/views/pantry_item_detail.dart';
import 'package:re_fridge/controllers/pantry_controller.dart';
import 'package:re_fridge/colors.dart';

class PantryItem extends GetView<PantryController> {
  final int index;
  late FToast fToast;
  PantryItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const cardRadius = 12.0;
    fToast = FToast();
    fToast.init(context);

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
                    bottomLeft: Radius.circular(cardRadius))
              ),
            ],
          ),
          child: ListTile(
            leading: Image.network(
              controller.foundIngredients[index].icon,
              width: 50,
              height: 50,
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
                controller.foundIngredients[index].quantity.toString() + ' EA',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Baloo2',
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(54, 40, 34, 1))),
            contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            onTap: () {
             Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PantryItemDetail(index: index)),
                  );
            }
          ),
          endActionPane: ActionPane(
            extentRatio: 0.25,
            motion: const ScrollMotion(),
            // A pane can dismiss the Slidable.
            dismissible: DismissiblePane(onDismissed: () {
              controller.deleteIngredient(index);
              showToast("Deleted", deleteToast);
            }),
            children: [
              SlidableAction(
                autoClose: true,
                onPressed: toCart(),
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

  deleteIngredient() {
    
  }

  toCart() {
    // to cart function
    
  }

  Widget deleteToast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Color.fromARGB(220, 254, 73, 73),
        ),
        child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
            Icon(Icons.delete, color: Colors.white),
            SizedBox(
            width: 12.0,
            ),
            Text("Deleted", style: TextStyle(color: Colors.white)),
        ],
        ),
    );

  Widget toCartToast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Color.fromARGB(220, 143, 180, 78),
        ),
        child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
            Icon(Icons.shopping_cart_outlined, color: Colors.white),
            SizedBox(
            width: 12.0,
            ),
            Text("Added to Cart", style: TextStyle(color: Colors.white)),
        ],
        ),
    );

  void showToast(String message, Widget toast) {
    fToast.showToast(
        child: toast,
        toastDuration: Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            bottom: 102.0,
            left: 0,
            right: 0
          );
        });
  }
}
