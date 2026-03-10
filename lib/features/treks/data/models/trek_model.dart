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
      image: json['imageUrl'] ?? json['image'] ?? '',
    );
  }

  // difficulty herera tei anusar color dincha
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

  String get localImage {
    final map = {
      'Kapuche Glacier Lake': 'assets/images/kapuche.jpg',
      'Sarangkot Sunrise Hike': 'assets/images/sarangkot.png',
      'Shivapuri Day Hike': 'assets/images/shivapuri.png',
      'Nagarkot Sunrise Hike': 'assets/images/nagarkot.png',
      'Ghorepani Poon Hill': 'assets/images/ghorepani.png',
      'Upper Mustang': 'assets/images/upper_mustang.png',
      'Mardi Himal': 'assets/images/mardi_himal.png',
      'Annapurna Base Camp': 'assets/images/annapurna_base.jpg',
      'Langtang Valley Trek': 'assets/images/langtang.png',
      'Annapurna Circuit Trek': 'assets/images/annapurna_circuit.png',
    };
    return map[name] ?? image;
  }
}
