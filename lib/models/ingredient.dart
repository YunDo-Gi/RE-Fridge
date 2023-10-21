class Ingredient {
  final int id; // 식재료 ID
  final String ingredientName; // 식재료 이름
  final DateTime expiryDate; // 유통기한 정보
  final int quantity; // 보유한 양 또는 갯수
  final String category; // 카테고리

  Ingredient({
    required this.id,
    required this.ingredientName,
    required this.expiryDate,
    required this.quantity,
    required this.category
  });
}