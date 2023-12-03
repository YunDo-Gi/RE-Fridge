import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:re_fridge/models/recipe.dart';

import 'package:re_fridge/models/tag.dart';
import 'recipe_controller.dart';


class TagController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final recipeController = Get.put(RecipeController());
  final List<Tag> tagsToSelect = [];
  final List<Tag> tagsSelected = [];

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  fetchData() async {
    if(tagsToSelect.length > 0) {
      return 0;
    }
    var serverPort = "8080";
    var serverPath = "/ingredient/tag";
    var url = Uri.http('localhost:' + serverPort, serverPath);

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var data = jsonResponse['data'];

        var tagList = <Tag>[];

        for (var item in data) {
          var tag = Tag.fromJson(item);
          tagList.add(tag);
        }
        tagsToSelect.assignAll(tagList);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Request failed - dummy data will be used.');
      var dummyData = await fetchDummyData();
      var tagList = <Tag>[];

      for (var item in dummyData) {
        var tag = Tag.fromJson(item);
        tagList.add(tag);
      }
      tagsToSelect.assignAll(tagList);
    } finally {
    }

    return 0;
  }

  void filterTag(String searchText) {
    if (searchText.isEmpty) {
      tagsToSelect.assignAll(tagsSelected);
      return;
    }

    tagsToSelect.assignAll(tagsSelected.where((tag) {
      return tag.ingredientName.toLowerCase().contains(searchText.toLowerCase());
    }));
  }

  addTag(Tag tag) {
    tagsSelected.add(tag);
    tagsToSelect.remove(tag);
    searchController.clear();

    for (var tag in tagsSelected) {
      print(tag.ingredientName);
    }
    update();
  }

  addToRecipeList(String recipeName, List<Tag> tagsSelected) {
    List<String> ingredients = [];
    for (var tag in tagsSelected) {
      ingredients.add(tag.ingredientName);
    }

    Recipe recipe = Recipe(
      recipeId: recipeController.recipes.length + 1,
      recipeName: recipeName,
      ingredients: ingredients,
    );

    recipeController.addRecipe(recipe);
  }



  fetchDummyData() async {
    await Future.delayed(Duration(seconds: 1));
    return [
      {
        "ingredientId": 1,
        "ingredientName": 'Carrot',
        "category": 'Vegetable',
        "icon": 'https://cdn-icons-png.flaticon.com/128/2224/2224115.png',
      },
      {
        "ingredientId": 2,
        "ingredientName": 'Chicken',
        "category": 'Meat',
        "icon": 'https://cdn-icons-png.flaticon.com/128/1041/1041676.png',
      },
      {
        "ingredientId": 3,
        "ingredientName": 'Salmon',
        "category": 'Fish',
        "icon": 'https://cdn-icons-png.flaticon.com/128/1915/1915297.png',
      },
      {
        "ingredientId": 4,
        "ingredientName": 'Milk',
        "category": 'Dairy',
        "icon": 'https://cdn-icons-png.flaticon.com/128/9708/9708499.png',
      },
      {
        "ingredientId": 5,
        "ingredientName": 'Egg',
        "category": 'Egg',
        "icon": 'https://cdn-icons-png.flaticon.com/128/837/837560.png',
      },
    ];
  }

  
}