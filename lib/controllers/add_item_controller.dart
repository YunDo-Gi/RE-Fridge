import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:re_fridge/controllers/pantry_controller.dart';
import 'package:re_fridge/models/ingredient.dart';

class AddItemController extends GetxController {
  final pantryController = Get.put(PantryController());

  List<Ingredient> ingredients = [
    Ingredient(
        ingredientId: 1,
        ingredientName: 'Carrot',
        category: 'Vegetable',
        icon: 'https://cdn-icons-png.flaticon.com/128/2224/2224115.png',
        quantity: 1,
        expiryDate: DateTime.now()),
    Ingredient(
        ingredientId: 2,
        ingredientName: 'Chicken',
        category: 'Meat',
        icon: 'https://cdn-icons-png.flaticon.com/128/1041/1041676.png',
        quantity: 1,
        expiryDate: DateTime.now()),
    Ingredient(
        ingredientId: 3,
        ingredientName: 'Salmon',
        category: 'Fish / Seafood',
        icon: 'https://cdn-icons-png.flaticon.com/128/1915/1915297.png',
        quantity: 1,
        expiryDate: DateTime.now()),
    Ingredient(
        ingredientId: 4,
        ingredientName: 'Milk',
        category: 'Dairy / Egg',
        icon: 'https://cdn-icons-png.flaticon.com/128/9708/9708499.png',
        quantity: 1,
        expiryDate: DateTime.now()),
    Ingredient(
        ingredientId: 5,
        ingredientName: 'Egg',
        category: 'Dairy / Egg',
        icon: 'https://cdn-icons-png.flaticon.com/128/837/837560.png',
        quantity: 1,
        expiryDate: DateTime.now()),
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
        return ingredient.ingredientName
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

  void addQuantity(int index) {
    addedIngredients[index].quantity++;
    addedIngredients[index] = addedIngredients[index];
  }

  void minusQuantity(int index) {
    if (addedIngredients[index].quantity > 1) {
      addedIngredients[index].quantity--;
      addedIngredients[index] = addedIngredients[index];
    }
  }

  void updateQuantity(int index, int updatedQuantity) {
    addedIngredients[index].quantity = updatedQuantity;
  }

  void updateExpiryDate(int index, DateTime updatedDate) {
    addedIngredients[index].expiryDate = updatedDate;
    addedIngredients[index] = addedIngredients[index];
  }

  void addToPantry(List<Ingredient> addedIngredients) {
    for (var ingredient in addedIngredients) {
      ingredient.ingredientId =
          pantryController.ingredients.last.ingredientId + 1;
      pantryController.addIngredient(ingredient);
    }
  }

  popBack(context) {
    int count = 0;
    Navigator.of(context).popUntil((_) => count++ >= 2);
    return 0;
  }
}
