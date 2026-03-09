class TrekModel {
  final String id;
  final String name;
  final String location;
  final String difficulty;
  final int duration;
  final double price;
  final String description;
  final String image;

  TrekModel({
    required this.id,
    required this.name,
    required this.location,
    required this.difficulty,
    required this.duration,
    required this.price,
    required this.description,
    required this.image,
  });

  // API response lai TrekModel ma convert garxa
  factory TrekModel.fromJson(Map<String, dynamic> json) {
    return TrekModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      difficulty: json['difficulty'] ?? 'Easy',
      duration: json['duration'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      image: json['image'] ?? '',
    );
  }

  // difficulty hेरेर color dिनxa
  String get difficultyLabel {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return 'Easy';
      case 'moderate':
        return 'Moderate';
      case 'hard':
        return 'Hard';
      default:
        return difficulty;
    }
  }
}
