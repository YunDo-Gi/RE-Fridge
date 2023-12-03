class CartItem {
  int cartId; // 카트 ID
  final String ingredientName; // 식재료 이름
  final String icon; // 아이콘

  CartItem({
    required this.cartId,
    required this.ingredientName,
    required this.icon,
  });

  // Convert from JSON
  factory CartItem.fromJson(Map<String, dynamic> json) {
    final cartId =  json['cartId'];
    final ingredientName = json['ingredientName'];
    final icon = json['icon'];

    // Check if all data is valid (runtime error prevention)
    if(cartId is int && ingredientName is String && icon is String) {
      return CartItem(
        cartId: cartId,
        ingredientName: ingredientName,
        icon: icon,
      );
    } else {
      throw FormatException('Invalid JSON: $json');
    }
  }

  // Convert to JSON
  Map<String, dynamic> toJson() => {
    'cartId': cartId,
    'ingredientName': ingredientName,
    'icon': icon,
  };
}