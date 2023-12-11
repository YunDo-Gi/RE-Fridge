import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../models/recipe.dart';

class RecipeController extends GetxController {
  var recipes = <Recipe>[].obs;
  var foundRecipes = <Recipe>[].obs;
  var availableRecipes = <Recipe>[].obs;

  bool searchMode = false;

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
        foundRecipes.assignAll(recipeList);
        print('Recipe: Request successful!');
      } else {
        print('Recipe: Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Recipe: Request failed - dummy data will be used.');
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

  List<Recipe> getAvailableRecipeByIngredient(String ingredientName) {
    var recipeList = <Recipe>[];

    for (var recipe in recipes) {
      for (var ingredient in recipe.ingredients) {
        if (ingredient.toLowerCase() == ingredientName.toLowerCase()) {
          recipeList.add(recipe);
        }
      }
    }
    availableRecipes.assignAll(recipeList);
    return recipeList;
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
    {
      "recipeId": 5,
      "recipeName": "Beef Stew",
      "ingredients": ["Beef", "Potato", "Carrot"],
      "fullfillCount": 3,
    },
  ];
}
