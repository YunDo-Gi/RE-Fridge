import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;


import 'package:get/get.dart';
import '../models/ingredient.dart';

class PantryController extends GetxController {
  final ingredients = <Ingredient>[].obs;


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
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    

    // var httpClient = HttpClient();
    // var httpResponseContent;

    // HttpClientRequest httpRequest = await httpClient.get(serverIp, serverPort, serverPath);
    // HttpClientResponse httpResponse = await httpRequest.close();

    // httpResponseContent = await utf8.decoder.bind(httpResponse).join();
    // printHttpContentInfo(httpResponse, httpResponseContent);
  }

    
    // await Future.delayed(const Duration(seconds: 1));
    // var dummyData = [
    //   Ingredient(
    //     id: 1,
    //     ingredientName: 'Milk',
    //     expiryDate: DateTime.now().add(const Duration(days: 7)),
    //     quantity: 1,
    //     category: 'Dairy'
    //   ),
    //   Ingredient(
    //     id: 2,
    //     ingredientName: 'Eggs',
    //     expiryDate: DateTime.now().add(const Duration(days: 14)),
    //     quantity: 14,
    //     category: 'Dairy'
    //   ),
    //   Ingredient(
    //     id: 3,
    //     ingredientName: 'Bread',
    //     expiryDate: DateTime.now().add(const Duration(days: 3)),
    //     quantity: 1,
    //     category: 'Bakery'
    //   ),
    // ];

    // ingredients.assignAll(dummyData);}

}