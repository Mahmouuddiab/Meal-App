class Ingredient {
  final String name;
  final String quantity;
  final String imageUrl;

  Ingredient({
    required this.name,
    required this.quantity,
    required this.imageUrl,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    final imageFile = json['image_url']?.split('/').last ?? '';
    return Ingredient(
      name: json['name'] as String,
      quantity: json['quantity'] as String,
      imageUrl: 'https://spoonacular.com/cdn/ingredients_250x250/$imageFile',
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'quantity': quantity,
    'image_url': imageUrl,
  };
}
