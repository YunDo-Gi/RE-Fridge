import 'package:get/get.dart';

class AddItemController extends GetxController {
  List<Ingredient> ingredients = [
    Ingredient(
        name: 'Carrot',
        category: 'Vegetable',
        icon: 'assets/icons/carrot.png'),
    Ingredient(
        name: 'Chicken', category: 'Meat', icon: 'assets/icons/meat.png'),
    Ingredient(
        name: 'Salmon',
        category: 'Fish / Seafood',
        icon: 'assets/icons/fish.png'),
    Ingredient(
        name: 'Milk', category: 'Dairy / Egg', icon: 'assets/icons/dairy.png'),
    Ingredient(
        name: 'Egg', category: 'Dairy / Egg', icon: 'assets/icons/egg.png'),
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

  void addIngredient(Ingredient ingredient) {
    addedIngredients.add(ingredient);
  }
}

class Ingredient {
  final String name;
  final String category;
  final String icon;

  Ingredient({required this.name, required this.category, required this.icon});
}
