import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AddItemController extends GetxController {
  List<Ingredient> ingredients = [
    Ingredient(
        name: 'Carrot',
        category: 'Vegetable',
        icon: 'https://cdn-icons-png.flaticon.com/128/2224/2224115.png'),
    Ingredient(
        name: 'Chicken', category: 'Meat', icon: 'https://cdn-icons-png.flaticon.com/128/1041/1041676.png'),
    Ingredient(
        name: 'Salmon',
        category: 'Fish / Seafood',
        icon: 'https://cdn-icons-png.flaticon.com/128/1915/1915297.png'),
    Ingredient(
        name: 'Milk', category: 'Dairy / Egg', icon: 'https://cdn-icons-png.flaticon.com/128/9708/9708499.png'),
    Ingredient(
        name: 'Egg', category: 'Dairy / Egg', icon: 'https://cdn-icons-png.flaticon.com/128/837/837560.png'),
  ];

  var foundIngredients = <Ingredient>[].obs;
  var addedIngredients = <Ingredient>[].obs;
 
  bool searchMode = false;

  void onInit() {
    super.onInit();
    foundIngredients.assignAll(ingredients);
  }

  void filterIngredient(String searchText) {
    var filteredIngredients = <Ingredient>[];

    if (searchText.isEmpty) {
      filteredIngredients = ingredients;
      searchMode = false;
    } else {
      filteredIngredients = ingredients.where((ingredient) {
        return ingredient.name
            .toLowerCase()
            .contains(searchText.toLowerCase());
      }).toList();
      searchMode = true;
    }

    foundIngredients.assignAll(filteredIngredients);
  }

  void addIngredient(int index) {
    addedIngredients.add(foundIngredients[index]);
  }

  void removeIngredient(int index) {
    addedIngredients.remove(addedIngredients[index]);
  }
}

class Ingredient {
  final String name;
  final String category;
  final String icon;

  Ingredient({required this.name, required this.category, required this.icon});
}
