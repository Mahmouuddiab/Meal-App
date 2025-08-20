class Ingredient {
  final String name;
  final String quantity;

  Ingredient({required this.name, required this.quantity});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'] as String,
      quantity: json['quantity'] as String,
    );
  }

  Map<String, dynamic> toJson() => {'name': name, 'quantity': quantity};
}
