class Meal {
  final String id;
  final String category;
  final String title;
  final String subtitle;
  final String time;
  final String imageUrl;

  Meal({
    required this.id,
    required this.category,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.imageUrl,
  });

  factory Meal.fromJson(Map<dynamic,dynamic> json) {
    return Meal(
      id: json['id'] as String,
      category: json['category'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      time: json['time'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'category': category,
    'title': title,
    'subtitle': subtitle,
    'time': time,
    'image_url': imageUrl,
  };
}
