class Nutrition {
  final String name;
  final double value;
  final String unit;

  Nutrition({required this.name, required this.value, required this.unit});

  factory Nutrition.fromJson(Map<String, dynamic> json) {
    return Nutrition(
      name: json['name'],
      value: (json['value'] as num).toDouble(),
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() => {'name': name, 'value': value, 'unit': unit};
}
