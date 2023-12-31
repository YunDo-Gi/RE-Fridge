import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:re_fridge/colors.dart';
import 'package:re_fridge/controllers/add_item_controller.dart';
import 'package:flutter/cupertino.dart';

class SetItem extends StatelessWidget {
  final addItemController = Get.put(AddItemController());
  late FToast fToast;

  @override
  Widget build(BuildContext context) {
    fToast = FToast();
    fToast.init(context);

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: TEXT_COLOR, //change your color here
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text('Set Item',
            style: TextStyle(
                color: Color.fromRGBO(54, 40, 34, 1),
                fontWeight: FontWeight.w700,
                fontSize: 30)),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: addItemController.addedIngredients.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.only(bottom: 12),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 24.0),
                                  child: Image(
                                    image: NetworkImage(addItemController
                                        .addedIngredients[index].icon),
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                  height: 40,
                                  width: 200,
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    color:
                                        BACKGROUND_COLOR, // Replace with your desired background color
                                    borderRadius: BorderRadius.circular(
                                        10), // Replace 10 with your desired border radius
                                  ),
                                  child: Text(
                                    addItemController
                                        .addedIngredients[index].ingredientName,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 18),
                                padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: BACKGROUND_COLOR,
                                    width: 2,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GetX<AddItemController>(
                                        builder: (controller) {
                                      return Text(
                                          '${controller.addedIngredients[index].expiryDate.toString().substring(0, 10)}',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Baloo2',
                                            fontWeight: FontWeight.w600,
                                          ));
                                    }),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: PRIMARY_COLOR,
                                        textStyle: const TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Tisa',
                                            fontWeight: FontWeight.w700),
                                      ),
                                      onPressed: () {
                                        showCupertinoModalPopup<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return GetX<AddItemController>(
                                                  builder: (controller) {
                                                return _buildBottomPicker(
                                                    timePicker(
                                                        index, controller));
                                              });
                                            });
                                      },
                                      child: const Text('Best Before'),
                                    )
                                  ],
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(top: 12),
                                      padding:
                                          EdgeInsets.fromLTRB(12, 0, 12, 0),
                                      height: 50,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: BACKGROUND_COLOR,
                                          width: 2,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 23,
                                            child: GetX<AddItemController>(
                                                builder: (controller) {
                                              return Text(
                                                  '${controller.addedIngredients[index].quantity}',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: 'Baloo2',
                                                    fontWeight: FontWeight.w600,
                                                  ));
                                            }),
                                          ),
                                          Text(
                                            ' EA',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Baloo2',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                ButtonBar(
                                  alignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 12),
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: PRIMARY_COLOR,
                                      ),
                                      child: IconButton(
                                        color: Colors.white,
                                        icon: Icon(Icons.add, size: 28),
                                        onPressed: () {
                                          addItemController.addQuantity(index);
                                        },
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(top: 12),
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: PRIMARY_COLOR,
                                        ),
                                        child: IconButton(
                                          color: Colors.white,
                                          icon: Icon(Icons.remove, size: 28),
                                          onPressed: () {
                                            addItemController
                                                .minusQuantity(index);
                                          },
                                        ))
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Confirm Button
            Container(
              margin: EdgeInsets.fromLTRB(32.0, 0, 32.0, 32.0),
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // add to pantry
                  addItemController
                      .addToPantry(addItemController.addedIngredients);
                  showToast(successToast);
                  // go back to pantry
                  int count = 0;
                  Navigator.of(context).popUntil((_) => count++ >= 2);
                  await Future.delayed(Duration(seconds: 1), () {
                    // remove from addedIngredients
                    addItemController.addedIngredients.clear();
                  });
                },
                child: Text('Confirm',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: PRIMARY_COLOR,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showToast(Widget toast) {
    fToast.showToast(
        child: toast,
        toastDuration: Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(child: child, bottom: 102.0, left: 0, right: 0);
        });
  }
}

Widget _buildBottomPicker(Widget picker) {
  return Container(
    height: 200,
    padding: const EdgeInsets.only(top: 6.0),
    color: CupertinoColors.white,
    child: DefaultTextStyle(
      style: const TextStyle(
        color: CupertinoColors.black,
        fontSize: 22.0,
      ),
      child: GestureDetector(
        // Blocks taps from propagating to the modal sheet and popping.
        onTap: () {},
        child: SafeArea(
          top: false,
          child: picker,
        ),
      ),
    ),
  );
}

Widget timePicker(index, controller) {
  return CupertinoDatePicker(
    mode: CupertinoDatePickerMode.date,
    initialDateTime: controller.addedIngredients[index].expiryDate,
    onDateTimeChanged: (DateTime newDateTime) {
      controller.updateExpiryDate(index, newDateTime);
    },
  );
}

Widget successToast = Container(
  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12.0),
    color: Color.fromARGB(220, 143, 180, 78),
  ),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.check_circle_outline, color: Colors.white),
      SizedBox(
        width: 12.0,
      ),
      Text("Successfully Added", style: TextStyle(color: Colors.white)),
    ],
  ),
);
