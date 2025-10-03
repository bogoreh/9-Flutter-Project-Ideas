class Recipe {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int cookingTime;
  final String difficulty;
  final List<String> categories;
  final double rating;
  final bool isFavorite;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.cookingTime,
    required this.difficulty,
    required this.categories,
    this.rating = 0.0,
    this.isFavorite = false,
  });

  Recipe copyWith({
    bool? isFavorite,
  }) {
    return Recipe(
      id: id,
      title: title,
      description: description,
      imageUrl: imageUrl,
      ingredients: ingredients,
      steps: steps,
      cookingTime: cookingTime,
      difficulty: difficulty,
      categories: categories,
      rating: rating,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}