import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:re_fridge/colors.dart';

import 'package:re_fridge/controllers/cart_controller.dart';
import '../models/ingredient.dart';
import '../models/cart_item.dart';
import 'package:re_fridge/models/category_data.dart';

class PantryController extends GetxController {
  final cartController = Get.put(CartController());
  final ingredients = <Ingredient>[].obs;
  final foundIngredients = <Ingredient>[].obs;
  Color color = PRIMARY_COLOR;

  int categoryIndex = 0;

  List numberByCategory = [].obs;

  bool searchMode = false;

  @override
  void onInit() {
    super.onInit();
    // TagController tagController = TagController();
    // tagController.fetchData();
    // fetchData();
  }

  Future fetchData() async {
    // Data is already fetched
    if (ingredients.length > 0) {
      return 0;
    }

    // Data is not fetched yet
    var serverPort = "8080";
    var serverPath = "/pantry";
    var url = Uri.http('localhost:' + serverPort, serverPath);

    try {
      var response = await http.get(url);
      print(response.statusCode);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var data = jsonResponse['data'];

        var ingredientsList = <Ingredient>[];

        for (var item in data) {
          var ingredient = Ingredient.fromJson(item);
          ingredientsList.add(ingredient);
        }

        ingredients.assignAll(ingredientsList);
        foundIngredients.assignAll(ingredients);
        print('Pantry: Request successful!');
      } else {
        print('Pantry: Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Pantry: Request failed - dummy data will be used.');
      var dummyData = await fetchDummyData();
      var ingredientsList = <Ingredient>[];

      for (var item in dummyData) {
        var ingredient = Ingredient.fromJson(item);
        ingredientsList.add(ingredient);
      }
      ingredients.assignAll(ingredientsList);
      foundIngredients.assignAll(ingredients);
    } finally {
      await getAverageExperationDate();

      getNumberByCategory();
    }

    return 0;
  }

  void categorizeIngredient(int category) {
    var filteredIngredients = <Ingredient>[];
    categoryIndex = category;

    switch (category) {
      case 0:
        filteredIngredients = ingredients;
        break;
      case 1:
        filteredIngredients = ingredients
            .where((ingredient) =>
                ingredient.category.toLowerCase() == 'vegetable')
            .toList();
        break;
      case 2:
        filteredIngredients = ingredients
            .where((ingredient) => ingredient.category.toLowerCase() == 'meat')
            .toList();
        break;
      case 3:
        filteredIngredients = ingredients
            .where((ingredient) =>
                ingredient.category.toLowerCase() == 'seafood' ||
                ingredient.category.toLowerCase() == 'fish')
            .toList();
        break;
      case 4:
        filteredIngredients = ingredients
            .where((ingredient) =>
                ingredient.category.toLowerCase() == 'dairy' ||
                ingredient.category.toLowerCase() == 'egg')
            .toList();
        break;
      default:
        filteredIngredients = ingredients;
    }

    foundIngredients.assignAll(filteredIngredients);
  }

  void filterIngredient(String searchText) {
    var filteredIngredients = <Ingredient>[];

    if (searchText.isEmpty) {
      filteredIngredients = ingredients;
      searchMode = false;
    } else {
      searchMode = true;
      filteredIngredients = ingredients.where((ingredient) {
        return ingredient.ingredientName
            .toLowerCase()
            .contains(searchText.toLowerCase());
      }).toList();
    }

    foundIngredients.assignAll(filteredIngredients);
  }

  // List<Ingredient> getIngredientsByCategory(String category) {
  //   var filteredIngredients = <Ingredient>[];

  //   filteredIngredients = ingredients.where((ingredient) {
  //     return ingredient.category.toLowerCase() == category.toLowerCase();
  //   }).toList();

  //   return filteredIngredients;
  // }

  void getNumberByCategory() {
    final categories = ['Vegetable', 'Meat', 'Fish', 'Dairy'];
    var numberByCategory = <int>[];
    var number = 0;

    for (var category in categories) {
      if (category == 'Fish') {
        number = ingredients.where((ingredient) {
          return ingredient.category.toLowerCase() == 'fish' ||
              ingredient.category.toLowerCase() == 'seafood';
        }).length;

        numberByCategory.add(number);
        continue;
      } else if (category == 'Dairy') {
        number = ingredients.where((ingredient) {
          return ingredient.category.toLowerCase() == 'dairy' ||
              ingredient.category.toLowerCase() == 'egg';
        }).length;

        numberByCategory.add(number);
        continue;
      } else {
        number = ingredients.where((ingredient) {
          return ingredient.category.toLowerCase() == category.toLowerCase();
        }).length;

        numberByCategory.add(number);
      }
    }
    this.numberByCategory = numberByCategory;
  }

  getCategoryImage(String category) {
    for (var i = 0; i < categoryAvatar.length; i++) {
      if (categoryAvatar[i]['category'] == category) {
        return categoryAvatar[i]['icon'];
      }
    }
  }

  getCategoryColor(String category) {
    for (var i = 0; i < categoryColor.length; i++) {
      if (categoryColor[i]['category'] == category) {
        return categoryColor[i]['color'];
      }
    }
  }

  Future deleteIngredient(int index) async {
    var ingredientId;
    if (searchMode) {
      ingredientId = foundIngredients[index].ingredientId;
    } else {
      if (categoryIndex == 0) {
        ingredientId = ingredients[index].ingredientId;
      } else {
        ingredientId = foundIngredients[index].ingredientId;
      }
    }

    var serverPort = "8080";
    var serverPath =
        "/pantry/" + ingredientId.toString();
    var url = await Uri.http('localhost:' + serverPort, serverPath);

    try {
      ingredients.removeAt(ingredients
          .indexWhere((ingredient) => ingredient.ingredientId == ingredientId));
      foundIngredients.removeAt(foundIngredients
          .indexWhere((ingredient) => ingredient.ingredientId == ingredientId));
      getNumberByCategory();
      ingredients.refresh();

      // Delete from server
      await http.delete(url);
      print('Pantry: Deleted from server');
    } catch (e) {
      print(e);
    }
  }

  Future addIngredient(Ingredient ingredient) async {
    ingredients.add(ingredient);
    foundIngredients.add(ingredient);
    getNumberByCategory();

    // Add to server
    // Connect to server
    var serverPort = "8080";
    var serverPath = "/pantry";
    var url = Uri.http('localhost:' + serverPort, serverPath);

    try {
      await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode([ingredient.toJson()]));
      print('Pantry: Added to server');
    } catch (e) {
      print('Pantry: Request failed - failed to add to server.');
    } finally {
      update();
    }
  }

  Future addToCart(ingredient) async {
    // Add to cart (local)
    // CartItem cartItem = CartItem(
    //     cartId: cartController.ingredients.length + 1,
    //     ingredientName: ingredient.ingredientName,
    //     icon: ingredient.icon);

    // cartController.addIngredient(cartItem);
    // print('Pantry: Added to cart');

    // // Add to cart (server)
    // var ingredientId = ingredient.ingredientId;

    // // Connect to server
    // var serverPort = "8080";
    // var serverPath = "/cart/" + ingredientId.toString();
    // var url = await Uri.http('localhost:' + serverPort, serverPath);

    // try {
    //   var response = await http.post(url);
    //   print(response.statusCode);

    //   if (response.statusCode == 200) {
    //     print('Pantry: Request successful!');
    //   } else {
    //     print('Pantry: Request failed with status: ${response.statusCode}.');
    //   }
    // } catch (e) {
    //   print('Pantry: Request failed - failed to add to cart.');
    // } finally {
    //   update();
    // }

    // return 0;
  }

  getAverageExperationDate() {
    var numberOfIngredients = ingredients.length;
    var count = 0;

    for (var ingredient in ingredients) {
      var difference = daysBetween(DateTime.now(), ingredient.expiryDate);
      if (difference < 5) {
        count++;
      } else {
        continue;
      }
    }

    if (count / numberOfIngredients < 0.25) {
      color = RED_COLOR;
    } else if (count / numberOfIngredients < 0.5) {
      color = YELLOW_COLOR;
    } else {
      color = PRIMARY_COLOR;
    }
  }

  // Experation Date Calculation
  int daysBetween(DateTime from, DateTime to) {
    var difference = to.difference(from).inDays;
    return difference;
  }

  Text toDDay(DateTime expiryDate) {
    var difference = daysBetween(DateTime.now(), expiryDate);
    if (difference == 0) {
      return Text('D-Day',
          style: TextStyle(
              color: Color.fromRGBO(217, 175, 82, 1),
              fontWeight: FontWeight.w700));
    } else if (difference < 0) {
      return Text('D+' + difference.abs().toString(),
          style: TextStyle(
              color: Color.fromRGBO(236, 97, 95, 1),
              fontWeight: FontWeight.w700));
    } else if (difference < 5) {
      return Text('D-' + difference.toString(),
          style: TextStyle(
              color: Color.fromRGBO(217, 175, 82, 1),
              fontWeight: FontWeight.w700));
    } else {
      return Text('D-' + difference.toString(),
          style: TextStyle(
              color: Color.fromRGBO(142, 180, 78, 1),
              fontWeight: FontWeight.w700));
    }
  }

  Color getExperationDateColor(DateTime expiryDate) {
    var difference = daysBetween(DateTime.now(), expiryDate);
    if (difference == 0) {
      return Color.fromRGBO(217, 175, 82, 1);
    } else if (difference < 0) {
      return Color.fromRGBO(236, 97, 95, 1);
    } else if (difference < 5) {
      return Color.fromRGBO(217, 175, 82, 1);
    } else {
      return Color.fromRGBO(142, 180, 78, 1);
    }
  }
}

Future fetchDummyData() async {
  await Future.delayed(Duration(seconds: 1));
  return [
    {
      "ingredientId": 1,
      "ingredientName": "Onion",
      "icon": "https://cdn-icons-png.flaticon.com/128/7230/7230868.png",
      "expiryDate": "2023-12-10",
      "quantity": 100,
      "category": "Vegetable"
    },
    {
      "ingredientId": 2,
      "ingredientName": "Beef",
      "icon": "https://cdn-icons-png.flaticon.com/128/6978/6978160.png",
      "expiryDate": "2021-10-10",
      "quantity": 100,
      "category": "Meat"
    },
    {
      "ingredientId": 3,
      "ingredientName": "salmon",
      "icon": 'https://cdn-icons-png.flaticon.com/128/2224/2224115.png',
      "expiryDate": "2021-10-10",
      "quantity": 100,
      "category": "Fish"
    },
    {
      "ingredientId": 4,
      "ingredientName": "carrot",
      "icon": 'https://cdn-icons-png.flaticon.com/128/2224/2224115.png',
      "expiryDate": "2021-10-10",
      "quantity": 100,
      "category": "Vegetable"
    },
    {
      "ingredientId": 5,
      "ingredientName": "Pork",
      "icon": 'https://cdn-icons-png.flaticon.com/128/2224/2224115.png',
      "expiryDate": "2021-10-10",
      "quantity": 100,
      "category": "Meat"
    },
    {
      "ingredientId": 6,
      "ingredientName": "Egg",
      "icon": 'https://cdn-icons-png.flaticon.com/128/2224/2224115.png',
      "expiryDate": "2021-10-10",
      "quantity": 100,
      "category": "Egg"
    },
    {
      "ingredientId": 7,
      "ingredientName": "Pepper",
      "icon": 'https://cdn-icons-png.flaticon.com/128/2224/2224115.png',
      "expiryDate": "2021-10-10",
      "quantity": 100,
      "category": "Vegetable"
    },
    {
      "ingredientId": 8,
      "ingredientName": "squid",
      "icon": 'https://cdn-icons-png.flaticon.com/128/2224/2224115.png',
      "expiryDate": "2021-10-10",
      "quantity": 100,
      "category": "Seafood"
    },
    {
      "ingredientId": 9,
      "ingredientName": "Milk",
      "icon": 'https://cdn-icons-png.flaticon.com/128/2224/2224115.png',
      "expiryDate": "2021-10-10",
      "quantity": 100,
      "category": "Dairy"
    },
  ];
}
