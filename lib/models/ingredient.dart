class Ingredient {
  int ingredientId; // 식재료 ID
  final String ingredientName; // 식재료 이름
  DateTime expiryDate; // 유통기한 정보
  final String icon; // 아이콘
  int quantity; // 보유한 양 또는 갯수
  final String category; // 카테고리

  Ingredient(
      {required this.ingredientId,
      required this.ingredientName,
      required this.icon,
      required this.expiryDate,
      required this.quantity,
      required this.category});

  // Convert from JSON
  factory Ingredient.fromJson(Map<String, dynamic> json) {
    final ingredientId = int.parse(json['ingredientId'].toString());
    final ingredientName = json['ingredientName'];
    final icon = json['icon'];
    final expiryDate = DateTime.parse(json['expiryDate']);
    final quantity = int.parse(json['quantity'].toString());
    final category = json['category'];

    // Check if all data is valid (runtime error prevention)
    if (ingredientName is String && icon is String && category is String) {
      return Ingredient(
          ingredientId: ingredientId,
          ingredientName: ingredientName,
          icon: icon,
          expiryDate: expiryDate,
          quantity: quantity,
          category: category);
    } else {
      throw FormatException('Invalid JSON: $json');
    }
  }

  // Convert to JSON
  Map<String, dynamic> toJson() => {
        'ingredientId': ingredientId,
        'ingredientName': ingredientName,
        'icon': icon,
        'expiryDate': expiryDate.toString().substring(0, 10),
        'quantity': quantity,
        'category': category
      };
}
