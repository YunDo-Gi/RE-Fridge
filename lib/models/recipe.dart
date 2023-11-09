class Recipe {
  final int recipeId;
  final String recipeName;
  final List<String> requiredIngredients;

  Recipe({
    required this.recipeId,
    required this.recipeName,
    required this.requiredIngredients,
  });

  // Convert from JSON
  factory Recipe.fromJson(Map<String, dynamic> json) {
    final recipeId = json['recipeId'];
    final recipeName = json['recipeName'];
    final requiredIngredients = json['requiredIngredients'];

    // Check if all data is valid (runtime error prevention)
    if (recipeId is int && recipeName is String && requiredIngredients is List<String>) {
      return Recipe(
        recipeId: recipeId,
        recipeName: recipeName,
        requiredIngredients: requiredIngredients,
      );
    } else {
      throw FormatException('Invalid JSON: $json');
    }
  }

  // Convert to JSON
  Map<String, dynamic> toJson() => {
        'recipeId': recipeId,
        'recipeName': recipeName,
        'requiredIngredients': requiredIngredients,
      };
}
