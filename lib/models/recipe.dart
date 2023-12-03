class Recipe {
  final int recipeId;
  final String recipeName;
  final List<String> ingredients;
  final int? fullfillCount;

  Recipe({
    required this.recipeId,
    required this.recipeName,
    required this.ingredients,
    this.fullfillCount,
  });

  // Convert from JSON
  factory Recipe.fromJson(Map<String, dynamic> json) {
    final recipeId = json['recipeId'];
    final recipeName = json['recipeName'];
    final ingredients = json['ingredients'];
    final fullfillCount = json['fullfillCount'];

    // Check if all data is valid (runtime error prevention)
    if (recipeId is int && recipeName is String && ingredients is List<String>) {
      return Recipe(
        recipeId: recipeId,
        recipeName: recipeName,
        ingredients: ingredients,
        fullfillCount: fullfillCount,
      );
    } else {
      throw FormatException('Invalid JSON: $json');
    }
  }

  // Convert to JSON
  Map<String, dynamic> toJson() => {
        'recipeId': recipeId,
        'recipeName': recipeName,
        'ingredients': ingredients,
        'fullfillCount': fullfillCount,
      };
}
