import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../models/recipe.dart';

class RecipeController extends GetxController {
  var recipes = <Recipe>[].obs;
  var foundRecipes = <Recipe>[].obs;

  bool searchMode = false;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future fetchData() async {
    var serverPort = "8080";
    var serverPath = "/recipe";
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
        foundRecipes.assignAll(recipeList);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Request failed - dummy data will be used.');
      var dummyData = await fetchDummyData();
      var recipeList = <Recipe>[];

      for (var item in dummyData) {
        var recipe = Recipe.fromJson(item);
        recipeList.add(recipe);
      }
      recipes.assignAll(recipeList);
      foundRecipes.assignAll(recipeList);
    } finally {}
  }

  void filterRecipe(String searchText) {
    var filteredRecipes = <Recipe>[];

    if (searchText.isEmpty) {
      filteredRecipes = recipes;
      searchMode = false;
    } else {
      searchMode = true;
      filteredRecipes = recipes.where((recipe) {
        return recipe.recipeName
            .toLowerCase()
            .contains(searchText.toLowerCase());
      }).toList();
    }

    foundRecipes.assignAll(filteredRecipes);
  }

  void addRecipe(Recipe recipe) {
    recipes.add(recipe);
    foundRecipes.add(recipe);
    print(foundRecipes.last.recipeName);
  }
}

Future fetchDummyData() async {
  await Future.delayed(Duration(seconds: 1));
  return [
    {
      "recipeId": 1,
      "recipeName": "Chickrot",
      "ingredients": ["Carrot", "Chicken"],
    },
    {
      "recipeId": 2,
      "recipeName": "Salmon Soup",
      "ingredients": ["Salmon", "Milk"],
    }
  ];
}
