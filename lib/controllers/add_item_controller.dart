import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AddItemController extends GetxController {
  var selectedDate = DateTime.now().obs;

  List<Ingredient> ingredients = [
    Ingredient(
      name: 'Carrot',
      category: 'Vegetable',
      icon: 'https://cdn-icons-png.flaticon.com/128/2224/2224115.png',
      quantity: 1,
      expiryDate: DateTime.now()),
    Ingredient(
      name: 'Chicken',
      category: 'Meat',
      icon: 'https://cdn-icons-png.flaticon.com/128/1041/1041676.png',
      quantity: 1,
      expiryDate: DateTime.now()),
    Ingredient(
      name: 'Salmon',
      category: 'Fish / Seafood',
      icon: 'https://cdn-icons-png.flaticon.com/128/1915/1915297.png',
      quantity: 1,
      expiryDate: DateTime.now()),
    Ingredient(
      name: 'Milk',
      category: 'Dairy / Egg',
      icon: 'https://cdn-icons-png.flaticon.com/128/9708/9708499.png',
      quantity: 1,
      expiryDate: DateTime.now()),
    Ingredient(
      name: 'Egg',
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
}



class Ingredient {
  final String name;
  final String category;
  final String icon;
  int quantity;
  DateTime expiryDate;

  Ingredient({required this.name, required this.category, required this.icon, required this.quantity, required this.expiryDate});
  
  Ingredient copywith({required int quantity}) {
    return Ingredient(
      name: this.name,
      category: this.category,
      icon: this.icon,
      quantity: quantity,
      expiryDate: this.expiryDate
    );
  }
}
