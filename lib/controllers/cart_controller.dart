import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import '../models/cart_item.dart';

class CartController extends GetxController {
  final ingredients = <CartItem>[].obs;

  bool searchMode = false;

  @override
  void onInit() {
    super.onInit();
    // fetchData();
  }

  Future fetchData() async {
    if(ingredients.length > 0) {
      return 0;
    }
    var serverPort = "8080";
    var serverPath = "/cart";
    var url = Uri.http('localhost:' + serverPort, serverPath);

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var data = jsonResponse['data'];

        var ingredientsList = <CartItem>[];

        for (var item in data) {
          var ingredient = CartItem.fromJson(item);
          ingredientsList.add(ingredient);
        }
        ingredients.assignAll(ingredientsList);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Request failed - dummy data will be used.');
      var dummyData = await fetchDummyData();
      var ingredientsList = <CartItem>[];

      for (var item in dummyData) {
        var ingredient = CartItem.fromJson(item);
        ingredientsList.add(ingredient);
      }
      ingredients.assignAll(ingredientsList);
    } finally {
      update();
    }

    return 0;
  }

  Future deleteIngredient(int index) async {
    // var serverPort = "8080";
    // var serverPath = "/pantry/" + cartId.toString();
    // var url = await Uri.http('localhost:' + serverPort, serverPath);

    var cartId = ingredients[index].cartId;

    try {
      // http.delete(url);
      ingredients.removeAt(ingredients
          .indexWhere((ingredient) => ingredient.cartId == cartId));
      ingredients.refresh();
    } catch (e) {
      print(e);
    }
  }

  addIngredient(CartItem cartItem) {
    ingredients.add(cartItem);
  }

  reloadList() {
    print('reload list');
    ingredients.refresh();
  }
}

Future fetchDummyData() async {
  await Future.delayed(Duration(seconds: 1));
  return [
    {
      "cartId": 1,
      "ingredientName": "Onion",
      "icon" : "https://cdn-icons-png.flaticon.com/128/7230/7230868.png",
    },
    {
      "cartId": 2,
      "ingredientName": "Beef",
      "icon" : "https://cdn-icons-png.flaticon.com/128/6978/6978160.png",
    },
    {
      "cartId": 3,
      "ingredientName": "Carrot",
      "icon": 'https://cdn-icons-png.flaticon.com/128/2224/2224115.png',
    },
  ];
}
