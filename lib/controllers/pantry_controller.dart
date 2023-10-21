import 'package:get/get.dart';
import '../models/ingredient.dart';

class PantryController extends GetxController {
  final ingredients = <Ingredient>[].obs;


  @override
  void onInit() {
    super.onInit();

    fetchData();

    
  }

  void fetchData() async {
    await Future.delayed(const Duration(seconds: 1));
    var dummyData = [
      Ingredient(
        id: 1,
        ingredientName: 'Milk',
        expiryDate: DateTime.now().add(const Duration(days: 7)),
        quantity: 1,
        category: 'Dairy'
      ),
      Ingredient(
        id: 2,
        ingredientName: 'Eggs',
        expiryDate: DateTime.now().add(const Duration(days: 14)),
        quantity: 14,
        category: 'Dairy'
      ),
      Ingredient(
        id: 3,
        ingredientName: 'Bread',
        expiryDate: DateTime.now().add(const Duration(days: 3)),
        quantity: 1,
        category: 'Bakery'
      ),
    ];

    ingredients.assignAll(dummyData);
  }

}