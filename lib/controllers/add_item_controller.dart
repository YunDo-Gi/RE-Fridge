import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import 'package:re_fridge/controllers/pantry_controller.dart';
import 'package:re_fridge/controllers/cart_controller.dart';
import 'package:re_fridge/models/ingredient.dart';
import 'package:re_fridge/models/cart_item.dart';

class AddItemController extends GetxController {
  final pantryController = Get.put(PantryController());
  final cartController = Get.put(CartController());

  List lengthByCategory = [].obs;
  int categoryIndex = 0;

  List<Ingredient> ingredients = [];

  var foundIngredients = <Ingredient>[].obs;
  var addedIngredients = <Ingredient>[].obs;

  var cartFoundIngredients = <Ingredient>[].obs;
  var cartAddedIngredients = <Ingredient>[].obs;

  bool searchMode = false;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future fetchData() async {
    // Data is already fetched
    if (ingredients.length > 0) {
      return 0;
    }

    // Data is not fetched yet
    var serverPort = "8080";
    var serverPath = "/ingredient";
    var url = Uri.http('localhost:' + serverPort, serverPath);

    try {
      var response = await http.get(url);
      print(response.statusCode);

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
        cartFoundIngredients.assignAll(ingredients);
        print('Ingredient: Request successful!');
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Ingredient: Request failed - dummy data will be used.');
      var dummyData = await fetchDummyData();
      var ingredientsList = <Ingredient>[];

      for (var item in dummyData) {
        var ingredient = Ingredient.fromJson(item);
        ingredientsList.add(ingredient);
      }
      ingredients.assignAll(ingredientsList);
      foundIngredients.assignAll(ingredients);
      cartFoundIngredients.assignAll(ingredients);
    } finally {
      getlengthByCategory();
    }

    return 0;
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

  void filterCartIngredient(String searchText) {
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

    cartFoundIngredients.assignAll(filteredIngredients);
  }

  void categorizeIngredient(int category) {
    var filteredIngredients = <Ingredient>[];
    categoryIndex = category;

    switch (category) {
      case 0:
        filteredIngredients = ingredients;
        break;
      case 1:
        filteredIngredients = ingredients
            .where((ingredient) =>
                ingredient.category.toLowerCase() == 'vegetable')
            .toList();
        break;
      case 2:
        filteredIngredients = ingredients
            .where((ingredient) => ingredient.category.toLowerCase() == 'meat')
            .toList();
        break;
      case 3:
        filteredIngredients = ingredients
            .where((ingredient) =>
                ingredient.category.toLowerCase() == 'seafood' ||
                ingredient.category.toLowerCase() == 'fish')
            .toList();
        break;
      case 4:
        filteredIngredients = ingredients
            .where((ingredient) =>
                ingredient.category.toLowerCase() == 'dairy' ||
                ingredient.category.toLowerCase() == 'egg')
            .toList();
        break;
      default:
        filteredIngredients = ingredients;
    }

    foundIngredients.assignAll(filteredIngredients);
  }

  void getlengthByCategory() {
    final categories = ['Vegetable', 'Meat', 'Fish', 'Dairy'];
    var lengthByCategory = <int>[];
    var length = 0;

    for (var category in categories) {
      if (category == 'Fish') {
        length = ingredients.where((ingredient) {
          return ingredient.category.toLowerCase() == 'fish' ||
              ingredient.category.toLowerCase() == 'seafood';
        }).length;

        lengthByCategory.add(length);
        continue;
      } else if (category == 'Dairy') {
        length = ingredients.where((ingredient) {
          return ingredient.category.toLowerCase() == 'dairy' ||
              ingredient.category.toLowerCase() == 'egg';
        }).length;

        lengthByCategory.add(length);
        continue;
      } else {
        length = ingredients.where((ingredient) {
          return ingredient.category.toLowerCase() == category.toLowerCase();
        }).length;

        lengthByCategory.add(length);
      }
    }
    print(lengthByCategory);
    this.lengthByCategory = lengthByCategory;
  }

  getCategoryfromIngredientName(String ingredientName) {
    for (var ingredient in ingredients) {
      if (ingredient.ingredientName.toLowerCase() ==
          ingredientName.toLowerCase()) {
        return ingredient.category;
      }
    }
    return 'Others';
  }

  void initialize() {
    foundIngredients.assignAll(ingredients);
    addedIngredients.clear();
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

  void addToCart(List<Ingredient> addedIngredients) {
    for (var ingredient in addedIngredients) {
      CartItem cartItem = CartItem(
          cartId: cartController.ingredients.last.cartId + 1,
          ingredientName: ingredient.ingredientName,
          icon: ingredient.icon);
      cartController.addIngredient(cartItem);
    }
  }

  popBack(context) {
    int count = 0;
    Navigator.of(context).popUntil((_) => count++ >= 2);
    return 0;
  }

  Future fetchDummyData() async {
    await Future.delayed(Duration(seconds: 1));
    return [
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
          category: 'Fish',
          icon: 'https://cdn-icons-png.flaticon.com/128/1915/1915297.png',
          quantity: 1,
          expiryDate: DateTime.now()),
      Ingredient(
          ingredientId: 4,
          ingredientName: 'Milk',
          category: 'Dairy',
          icon: 'https://cdn-icons-png.flaticon.com/128/9708/9708499.png',
          quantity: 1,
          expiryDate: DateTime.now()),
      Ingredient(
          ingredientId: 5,
          ingredientName: 'Egg',
          category: 'Egg',
          icon: 'https://cdn-icons-png.flaticon.com/128/837/837560.png',
          quantity: 1,
          expiryDate: DateTime.now()),
    ];
  }
}
