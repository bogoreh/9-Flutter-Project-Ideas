import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../data/dummy_data.dart';
import '../widgets/recipe_card.dart';
import '../widgets/category_chip.dart';
import 'recipe_detail_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Recipe> _recipes = [];
  List<Recipe> _filteredRecipes = [];
  Set<String> _selectedCategories = {};
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _recipes = dummyRecipes;
    _filteredRecipes = _recipes;
    _searchController.addListener(_filterRecipes);
  }

  void _filterRecipes() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredRecipes = _recipes.where((recipe) {
        final matchesSearch = recipe.title.toLowerCase().contains(query) ||
            recipe.description.toLowerCase().contains(query);
        final matchesCategory = _selectedCategories.isEmpty ||
            recipe.categories.any((category) => _selectedCategories.contains(category));
        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  void _toggleCategory(String category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else {
        _selectedCategories.add(category);
      }
      _filterRecipes();
    });
  }

  void _toggleFavorite(String recipeId) {
    setState(() {
      final index = _recipes.indexWhere((recipe) => recipe.id == recipeId);
      if (index != -1) {
        _recipes[index] = _recipes[index].copyWith(
          isFavorite: !_recipes[index].isFavorite,
        );
      }
      _filterRecipes();
    });
  }

  void _navigateToRecipeDetail(Recipe recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetailScreen(
          recipe: recipe,
          onFavoriteToggle: () => _toggleFavorite(recipe.id),
        ),
      ),
    );
  }

  void _navigateToFavorites() {
    final favoriteRecipes = _recipes.where((recipe) => recipe.isFavorite).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoritesScreen(
          favoriteRecipes: favoriteRecipes,
          onFavoriteToggle: _toggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final allCategories = _recipes.expand((recipe) => recipe.categories).toSet().toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Food Recipes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: _navigateToFavorites,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search recipes...',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Categories
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: allCategories.map((category) {
                  return CategoryChip(
                    category: category,
                    isSelected: _selectedCategories.contains(category),
                    onTap: () => _toggleCategory(category),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Recipes Count
            Text(
              '${_filteredRecipes.length} Recipes Found',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),

            // Recipes Grid
            Expanded(
              child: _filteredRecipes.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No recipes found',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: _filteredRecipes.length,
                      itemBuilder: (context, index) {
                        final recipe = _filteredRecipes[index];
                        return RecipeCard(
                          recipe: recipe,
                          onTap: () => _navigateToRecipeDetail(recipe),
                          onFavoriteToggle: () => _toggleFavorite(recipe.id),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}