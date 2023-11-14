import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import '../models/ingredient.dart';

class PantryController extends GetxController {
  final ingredients = <Ingredient>[].obs;
  final foundIngredients = <Ingredient>[].obs;

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
      print(e);
    } finally {
      var dummyData = await fetchDummyData();
      var ingredientsList = <Ingredient>[];

      for (var item in dummyData) {
        var ingredient = Ingredient.fromJson(item);
        ingredientsList.add(ingredient);
      }
      ingredients.assignAll(ingredientsList);
      foundIngredients.assignAll(ingredients);
    }
  }

  void filterIngredient(String searchText) {
    var filteredIngredients = <Ingredient>[];

    if (searchText.isEmpty) {
      filteredIngredients = ingredients;
    } else {
      filteredIngredients = ingredients.where((ingredient) {
        return ingredient.ingredientName
            .toLowerCase()
            .contains(searchText.toLowerCase());
      }).toList();
    }

    foundIngredients.assignAll(filteredIngredients);
  }

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
      "expiryDate": "2021-10-10",
      "quantity": 100,
      "category": "Vegetable"
    },
    {
      "ingredientId": 2,
      "ingredientName": "Gochujang",
      "expiryDate": "2021-10-10",
      "quantity": 100,
      "category": "Seasoning"
    },
    {
      "ingredientId": 3,
      "ingredientName": "Red Pepper Powder",
      "expiryDate": "2021-10-10",
      "quantity": 100,
      "category": "Seasoning"
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
      "ingredientName": "Gochujang",
      "expiryDate": "2021-10-10",
      "quantity": 100,
      "category": "Seasoning"
    },
    {
      "ingredientId": 6,
      "ingredientName": "Red Pepper Powder",
      "expiryDate": "2021-10-10",
      "quantity": 100,
      "category": "Seasoning"
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
      "ingredientName": "Gochujang",
      "expiryDate": "2021-10-10",
      "quantity": 100,
      "category": "Seasoning"
    },
    {
      "ingredientId": 9,
      "ingredientName": "Red Pepper Powder",
      "expiryDate": "2021-10-10",
      "quantity": 100,
      "category": "Seasoning"
    },
  ];
}
