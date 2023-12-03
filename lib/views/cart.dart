import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:re_fridge/colors.dart';
import 'package:re_fridge/controllers/cart_controller.dart';
import 'package:re_fridge/views/add_cart_item.dart';
import 'package:re_fridge/widgets/cart_card.dart';

class Cart extends StatelessWidget {
  final String title = 'Cart';

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: TEXT_COLOR, //change your color here
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text('Cart',
            style: TextStyle(
                color: Color.fromRGBO(54, 40, 34, 1),
                fontWeight: FontWeight.w700,
                fontSize: 30)),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline_rounded),
            color: Color.fromRGBO(54, 40, 34, 1),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddCartItem()),
              );
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: cartController.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
              child: GetX<CartController>(builder: (controller) {
                return ListView.builder(
                  itemCount: cartController.ingredients.length,
                  itemBuilder: (context, index) {
                    return CartCard(index: index);
                  },
                );
              }),
            );
          } else {
            return Center(
                child: CircularProgressIndicator(
              color: PRIMARY_COLOR,
            ));
          }
        },
      ),
    );
  }
}
