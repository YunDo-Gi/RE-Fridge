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
  }

  void filterIngredient(String searchText) {
    var filteredIngredients = <Ingredient>[];

    if (searchText.isEmpty) {
      filteredIngredients = ingredients;
    } else {
      filteredIngredients = ingredients.where((ingredient) {
        return ingredient.ingredientName.toLowerCase().contains(searchText.toLowerCase());
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
    if(difference == 0) {
      return Text('D-Day');
    } else if(difference < 0) {
      return Text('D+' + difference.abs().toString(), style: TextStyle(color:const Color(0xEC615F)));
    } else if(difference < 5) {
      return Text('D-' + difference.toString(), style: TextStyle(color: const Color(0xD9AF52)));
    } else {
      return Text('D-' + difference.toString(), style: TextStyle(color: const Color(0x8EB44E)));
    }
  }
}