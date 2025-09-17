import 'package:flutter/material.dart';
import '../widgets/coffee_card.dart';
import '../widgets/category_chip.dart';
import '../utils/constants.dart';
import '../models/coffee.dart';
import 'product_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategory = 0;
  final List<String> categories = ['All', 'Espresso', 'Cappuccino', 'Latte', 'Cold Brew'];

  // Sample coffee data
  final List<Coffee> coffees = [
    Coffee(
      id: '1',
      name: 'Espresso',
      description: 'Strong and bold coffee',
      price: 3.99,
      imagePath: 'assets/images/espresso.jpg',
      category: 'Espresso',
      ingredients: ['Espresso'],
    ),
    Coffee(
      id: '2',
      name: 'Cappuccino',
      description: 'Perfect balance of espresso, steamed milk, and foam',
      price: 4.99,
      imagePath: 'assets/images/cappuccino.jpg',
      category: 'Cappuccino',
      ingredients: ['Espresso', 'Steamed Milk', 'Foam'],
    ),
    Coffee(
      id: '3',
      name: 'Latte',
      description: 'Smooth and creamy coffee drink',
      price: 4.49,
      imagePath: 'assets/images/latte.jpg',
      category: 'Latte',
      ingredients: ['Espresso', 'Steamed Milk'],
    ),
    Coffee(
      id: '4',
      name: 'Cold Brew',
      description: 'Smooth cold coffee with low acidity',
      price: 4.99,
      imagePath: 'assets/images/cold_brew.jpg',
      category: 'Cold Brew',
      ingredients: ['Cold Brew Coffee'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Coffee Shop',
          style: TextStyle(color: AppColors.textLight),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textLight),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: AppColors.textLight),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Categories',
              style: AppTextStyles.headline1,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryChip(
                    label: categories[index],
                    isSelected: _selectedCategory == index,
                    onTap: () {
                      setState(() {
                        _selectedCategory = index;
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Popular Now',
              style: AppTextStyles.headline1,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 240,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: coffees.length,
                itemBuilder: (context, index) {
                  return CoffeeCard(
                    coffee: coffees[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductScreen(coffee: coffees[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Special Offers',
              style: AppTextStyles.headline1,
            ),
            const SizedBox(height: 16),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/images/coffee_offer.jpg'),
                  fit: BoxFit.cover,
                  opacity: 0.8,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Buy 1 Get 1 Free',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textLight,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'On all espresso drinks until Friday',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}