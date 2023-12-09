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
    final recipeId = int.parse(json['recipeId'].toString());
    final recipeName = json['recipeName'];
    final ingredients = List<String>.from(json['ingredients']);
    final fullfillCount = int.parse(json['fullfillCount'].toString());

    return Recipe(
      recipeId: recipeId,
      recipeName: recipeName,
      ingredients: ingredients,
      fullfillCount: fullfillCount,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() => {
        'recipeId': recipeId,
        'recipeName': recipeName,
        'ingredients': ingredients,
        'fullfillCount': fullfillCount,
      };
}
