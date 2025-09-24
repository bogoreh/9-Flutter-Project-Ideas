class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final String description;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.description,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      types: List<String>.from(json['types']),
      description: json['description'],
    );
  }
}