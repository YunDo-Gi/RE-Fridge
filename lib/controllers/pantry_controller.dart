import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import '../models/ingredient.dart';

class PantryController extends GetxController {
  final ingredients = <Ingredient>[].obs;
  final foundIngredients = <Ingredient>[].obs;

  final categoryIndex = 0.obs;

  List numberByCategory = [].obs;

  bool searchMode = false;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future fetchData() async {
    var serverPort = "8080";
    var serverPath = "/pantry";
    var url = Uri.http('localhost:' + serverPort, serverPath);

    try {
      var response = await http.get(url);

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
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Request failed - dummy data will be used.');
      var dummyData = await fetchDummyData();
      var ingredientsList = <Ingredient>[];

      for (var item in dummyData) {
        var ingredient = Ingredient.fromJson(item);
        ingredientsList.add(ingredient);
      }
      ingredients.assignAll(ingredientsList);
      foundIngredients.assignAll(ingredients);
    } finally {
      getNumberByCategory();
    }
  }

  void categorizeIngredient(int category) {
    var filteredIngredients = <Ingredient>[];

    switch (category) {
      case 0:
        filteredIngredients = ingredients;
        break;
      case 1:
        filteredIngredients = ingredients
            .where((ingredient) => ingredient.category.toLowerCase() == 'vegetable')
            .toList();
        break;
      case 2:
        filteredIngredients =
            ingredients.where((ingredient) => ingredient.category.toLowerCase() == 'meat').toList();
        break;
      case 3:
        filteredIngredients = ingredients
            .where((ingredient) => ingredient.category.toLowerCase() == 'seafood' || ingredient.category.toLowerCase() == 'fish')
            .toList();
        break;
      case 4:
        filteredIngredients =
            ingredients.where((ingredient) => ingredient.category.toLowerCase() == 'dairy' || ingredient.category.toLowerCase() == 'egg').toList();
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
      if(category == 'Fish') {
        number = ingredients.where((ingredient) {
          return ingredient.category.toLowerCase() == 'fish' || ingredient.category.toLowerCase() == 'seafood';
        }).length;

        numberByCategory.add(number);
        continue;
      } else if(category == 'Dairy') {
        number = ingredients.where((ingredient) {
          return ingredient.category.toLowerCase() == 'dairy' || ingredient.category.toLowerCase() == 'egg';
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
    print(numberByCategory);
    this.numberByCategory = numberByCategory;
  }

  

  Future deleteIngredient(int index) async {
    // var serverPort = "8080";
    // var serverPath = "/pantry/" + ingredientId.toString();
    // var url = await Uri.http('localhost:' + serverPort, serverPath);

    var ingredientId;
    if (searchMode) {
      ingredientId = foundIngredients[index].ingredientId;
    } else {
      ingredientId = ingredients[index].ingredientId;
    }

    try {
      // http.delete(url);
      ingredients.removeAt(ingredients
          .indexWhere((ingredient) => ingredient.ingredientId == ingredientId));
      foundIngredients.removeAt(foundIngredients
          .indexWhere((ingredient) => ingredient.ingredientId == ingredientId));
      getNumberByCategory();
      ingredients.refresh();
    } catch (e) {
      print(e);
    }
  }

  Future addToCart(index) async {
    // var serverPort = "8080";
    // var serverPath = "/cart";
    // var url = await Uri.http('localhost:' + serverPort, serverPath);
    var ingredientId = ingredients[index].ingredientId;

    try {
      // http.post(url, body: {'ingredientId': ingredientId.toString()});
    } catch (e) {
      print(e);
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
      return Text('D-Day');
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
}

Future fetchDummyData() async {
  await Future.delayed(Duration(seconds: 1));
  return [
    {
      "ingredientId": 1,
      "ingredientName": "Onion",
      "expiryDate": "2023-12-10",
      "quantity": 100,
      "category": "Vegetable"
    },
    {
      "ingredientId": 2,
      "ingredientName": "Beef",
      "expiryDate": "2021-10-10",
      "quantity": 100,
      "category": "Meat"
    },
    {
      "ingredientId": 3,
      "ingredientName": "salmon",
      "expiryDate": "2021-10-10",
      "quantity": 100,
      "category": "Fish"
    },
    {
      "ingredientId": 4,
      "ingredientName": "carrot",
      "expiryDate": "2021-10-10",
      "quantity": 100,
      "category": "Vegetable"
    },
    {
      "ingredientId": 5,
      "ingredientName": "Pork",
      "expiryDate": "2021-10-10",
      "quantity": 100,
      "category": "Meat"
    },
    {
      "ingredientId": 6,
      "ingredientName": "Egg",
      "expiryDate": "2021-10-10",
      "quantity": 100,
      "category": "Egg"
    },
    {
      "ingredientId": 7,
      "ingredientName": "Pepper",
      "expiryDate": "2021-10-10",
      "quantity": 100,
      "category": "Vegetable"
    },
    {
      "ingredientId": 8,
      "ingredientName": "squid",
      "expiryDate": "2021-10-10",
      "quantity": 100,
      "category": "Seafood"
    },
    {
      "ingredientId": 9,
      "ingredientName": "Milk",
      "expiryDate": "2021-10-10",
      "quantity": 100,
      "category": "Dairy"
    },
  ];
}
