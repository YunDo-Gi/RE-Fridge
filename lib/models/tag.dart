class Tag {
  final int ingredientId;
  final String ingredientName;
  final String category;
  final String icon;

  Tag({
    required this.ingredientId,
    required this.ingredientName,
    required this.category,
    required this.icon,
  });

  // Convert from JSON
  factory Tag.fromJson(Map<String, dynamic> json) {
    final ingredientId = int.parse(json['ingredientId'].toString());
    final ingredientName = json['ingredientName'];
    final category = json['category'];
    final icon = json['icon'];

    // Check if all data is valingredientId (runtime error prevention)
    if (ingredientName is String && category is String && icon is String) {
      return Tag(
        ingredientId: ingredientId,
        ingredientName: ingredientName,
        category: category,
        icon: icon,
      );
    } else {
      throw FormatException('Invalid JSON: $json');
    }
  }

  // Convert to JSON
  Map<String, dynamic> toJson() => {
        'ingredientId': ingredientId,
        'ingredientName': ingredientName,
        'category': category,
        'icon': icon,
      };
}
