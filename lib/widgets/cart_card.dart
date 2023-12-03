import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:re_fridge/controllers/cart_controller.dart';

class CartCard extends GetView<CartController> {
  final int index;
  late FToast fToast;
  CartCard({Key? key, required this.index}) : super(key: key);

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
          child: ListTile(
            leading: Image.network(
              controller.ingredients[index].icon,
              width: 50,
              height: 50,
            ),
            title: Text(controller.ingredients[index].ingredientName,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(54, 40, 34, 1))),
            contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
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
                      bottomRight: Radius.circular(cardRadius))),
            ],
          ),
        ));
  }

  deleteIngredient() {}

  toCart() {}

  void showToast(String message, Widget toast) {
    fToast.showToast(
        child: toast,
        toastDuration: Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(child: child, bottom: 102.0, left: 0, right: 0);
        });
  }
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
