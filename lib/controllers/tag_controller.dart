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
  final List<Tag> tagsSelectable = [];
  final List<Tag> tagsSelected = [];

  @override
  void onInit() {
    super.onInit();
    // fetchData();
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
        tagsSelectable.assignAll(tagList);
        print('Tag: Request successful!');
      } else {
        print('Tag: Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Tag: Request failed - dummy data will be used.');
      var dummyData = await fetchDummyData();
      var tagList = <Tag>[];

      for (var item in dummyData) {
        var tag = Tag.fromJson(item);
        tagList.add(tag);
      }
      tagsToSelect.assignAll(tagList);
      tagsSelectable.assignAll(tagList);
    } finally {
      update();
    }

    return 0;
  }

  void filterTag(String searchText) {
    if (searchText.isEmpty) {
      tagsSelectable.assignAll(tagsSelected);
      return;
    }

    tagsSelectable.assignAll(tagsSelected.where((tag) {
      return tag.ingredientName.toLowerCase().contains(searchText.toLowerCase());
    }));
  }

  addTag(Tag tag) {
    tagsSelected.add(tag);
    tagsSelectable.remove(tag);
    searchController.clear();

    for (var tag in tagsSelected) {
      print(tag.ingredientName);
    }
    update();
  }

  deleteTag(int index) {
    tagsSelectable.add(tagsSelected[index]);
    tagsSelected.removeAt(index);
    update();
  }

  reloadTags() {
    tagsSelectable.assignAll(tagsToSelect);
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
      "ingredientName": "Onion",
      "icon": "https://cdn-icons-png.flaticon.com/128/7230/7230868.png",
      "expiryDate": DateTime.now().toString().substring(0, 10),
      "quantity": 1,
      "category": "Vegetable"
    },
    {
      "ingredientId": 2,
      "ingredientName": "Beef",
      "icon": "https://cdn-icons-png.flaticon.com/128/6978/6978160.png",
      "expiryDate": DateTime.now().toString().substring(0, 10),
      "quantity": 1,
      "category": "Meat"
    },
    {
      "ingredientId": 3,
      "ingredientName": "Milk",
      "icon": 'https://cdn-icons-png.flaticon.com/128/2049/2049100.png',
      "expiryDate": DateTime.now().toString().substring(0, 10),
      "quantity": 1,
      "category": "Dairy"
    },
    {
      "ingredientId": 4,
      "ingredientName": "Carrot",
      "icon": 'https://cdn-icons-png.flaticon.com/128/2224/2224115.png',
      "expiryDate": DateTime.now().toString().substring(0, 10),
      "quantity": 1,
      "category": "Vegetable"
    },
    {
      "ingredientId": 5,
      "ingredientName": "Lamb",
      "icon": 'https://cdn-icons-png.flaticon.com/128/2403/2403227.png',
      "expiryDate": DateTime.now().toString().substring(0, 10),
      "quantity": 1,
      "category": "Meat"
    },
    {
      "ingredientId": 6,
      "ingredientName": "Egg",
      "icon": 'https://cdn-icons-png.flaticon.com/128/837/837560.png',
      "expiryDate": DateTime.now().toString().substring(0, 10),
      "quantity": 1,
      "category": "Egg"
    },
    {
      "ingredientId": 7,
      "ingredientName": "Broccoli",
      "icon": 'https://cdn-icons-png.flaticon.com/128/2346/2346952.png',
      "expiryDate": DateTime.now().toString().substring(0, 10),
      "quantity": 1,
      "category": "Vegetable"
    },
    {
      "ingredientId": 8,
      "ingredientName": "Shrimp",
      "icon": 'https://cdn-icons-png.flaticon.com/128/2970/2970030.png',
      "expiryDate": DateTime.now().toString().substring(0, 10),
      "quantity": 1,
      "category": "Seafood"
    },
    {
      "ingredientId": 9,
      "ingredientName": "Cheese",
      "icon": 'https://cdn-icons-png.flaticon.com/128/517/517561.png',
      "expiryDate": DateTime.now().toString().substring(0, 10),
      "quantity": 1,
      "category": "Dairy"
    },
    {
      "ingredientId": 10,
      "ingredientName": "Salmon",
      "icon": 'https://cdn-icons-png.flaticon.com/128/1915/1915297.png',
      "expiryDate": DateTime.now().toString().substring(0, 10),
      "quantity": 1,
      "category": "Fish"
    },
    {
      "ingredientId": 11,
      "ingredientName": "Potato",
      "icon": 'https://cdn-icons-png.flaticon.com/128/1135/1135548.png',
      "expiryDate": DateTime.now().toString().substring(0, 10),
      "quantity": 1,
      "category": "Vegetable"
    },
    {
      "ingredientId": 12,
      "ingredientName": "Tomato",
      "icon": 'https://cdn-icons-png.flaticon.com/128/1812/1812043.png',
      "expiryDate": DateTime.now().toString().substring(0, 10),
      "quantity": 1,
      "category": "Vegetable"
    },
    {
      "ingredientId": 13,
      "ingredientName": "Chicken",
      "icon": 'https://cdn-icons-png.flaticon.com/128/8119/8119002.png',
      "expiryDate": DateTime.now().toString().substring(0, 10),
      "quantity": 1,
      "category": "Meat"
    },
    {
      "ingredientId": 14,
      "ingredientName": "Lettuce",
      "icon": 'https://cdn-icons-png.flaticon.com/128/5346/5346093.png',
      "expiryDate": DateTime.now().toString().substring(0, 10),
      "quantity": 1,
      "category": "Vegetable"
    },
    {
      "ingredientId": 15,
      "ingredientName": "Pork",
      "icon": 'https://cdn-icons-png.flaticon.com/128/1391/1391338.png',
      "expiryDate": DateTime.now().toString().substring(0, 10),
      "quantity": 1,
      "category": "Meat"
    },
    {
      "ingredientId": 16,
      "ingredientName": "Mackerel",
      "icon": 'https://cdn-icons-png.flaticon.com/128/2195/2195189.png',
      "expiryDate": DateTime.now().toString().substring(0, 10),
      "quantity": 1,
      "category": "Fish"
    },
  ];
  }

  
}