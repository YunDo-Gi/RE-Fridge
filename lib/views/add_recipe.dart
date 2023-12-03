import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import 'package:re_fridge/controllers/add_recipe_controller.dart';

class AddRecipe extends StatelessWidget {
  late FToast fToast;

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
        title: Text('Pantry',
            style: TextStyle(
                color: Color.fromRGBO(54, 40, 34, 1),
                fontWeight: FontWeight.w700,
                fontSize: 30)),
      ),
      body: ButtonBar(
        children: <Widget>[
          TextButton(
            child: Text('Add Recipe'),
            onPressed: () {
              showDialog(
                barrierColor: Color.fromRGBO(54, 40, 34, 0.7),
                barrierDismissible: true,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // Change the border radius here
                    ),
                    title: Text('Enter Recipe Information'),
                    content: TextField(
                      // Add your text field properties here
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Save'),
                        onPressed: () {
                          // Handle saving the inputted information
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void showToast(String message, Widget toast) {
    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 2),
      positionedToastBuilder: (context, child) {
        return Positioned(
          child: child,
          bottom: 220.0,
          left: 0,
          right: 0,
        );
      },
    );
  }
}