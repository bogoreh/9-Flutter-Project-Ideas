class Coffee {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imagePath;
  final String category;
  final List<String> ingredients;
  final double rating;
  final int ratingCount;

  Coffee({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.category,
    required this.ingredients,
    this.rating = 4.5,
    this.ratingCount = 100,
  });
}