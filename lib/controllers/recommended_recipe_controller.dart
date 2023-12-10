import 'dart:convert';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../models/recipe.dart';

class RecommendedRecipeController extends GetxController {
  var recipes = <Recipe>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }
  
  Future fetchData() async {
    var serverPort = "8080";
    var serverPath = "/recipe/fullfill";
    var url = Uri.http('localhost:' + serverPort, serverPath);

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var data = jsonResponse['data'];

        var recipeList = <Recipe>[];

        for (var item in data) {
          var recipe = Recipe.fromJson(item);
          recipeList.add(recipe);
        }
        recipes.assignAll(recipeList);
        print('Recommended Recipe: Request successful!');
      } else {
        print('Recommended Recipe: Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Recommended Recipe: Request failed - dummy data will be used.');
      var dummyData = await fetchDummyData();
      var recipeList = <Recipe>[];

      for (var item in dummyData) {
        var ingredient = Recipe.fromJson(item);
        recipeList.add(ingredient);
      }
      recipes.assignAll(recipeList);
    } finally {
    }
  }
}

Future fetchDummyData() async {
  await Future.delayed(Duration(seconds: 1));
  return [
    {
      "recipeId": 1,
      "recipeName": "Lamb Steak",
      "ingredients": ["Lamb", "Broccoli"],
      "fullfillCount": 2,
    },
    {
      "recipeId": 2,
      "recipeName": "Salmon Soup",
      "ingredients": ["Salmon", "Milk", "Onion"],
      "fullfillCount": 3,
    },
    {
      "recipeId": 3,
      "recipeName": "Chicken Salad",
      "ingredients": ["Chicken", "Lettuce", "Tomato"],
      "fullfillCount": 3,
    },
    {
      "recipeId": 4,
      "recipeName": "Pork Cutlet",
      "ingredients": ["Pork", "Egg", "Bread Crumbs"],
      "fullfillCount": 2,
    },
  ];
}