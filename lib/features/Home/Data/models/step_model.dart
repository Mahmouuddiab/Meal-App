class Steps {
  final int step;
  final String description;

  Steps({required this.step, required this.description});

  factory Steps.fromJson(Map<String, dynamic> json) {
    return Steps(
      step: json['step'] as int,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() => {'step': step, 'description': description};
}
