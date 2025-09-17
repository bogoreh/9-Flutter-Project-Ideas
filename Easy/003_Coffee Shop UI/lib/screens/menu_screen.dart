import 'package:flutter/material.dart';
import '../widgets/coffee_card.dart';
import '../widgets/category_chip.dart';
import '../utils/constants.dart';
import '../models/coffee.dart';
import './product_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
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
    Coffee(
      id: '5',
      name: 'Mocha',
      description: 'Chocolatey coffee delight',
      price: 5.49,
      imagePath: 'assets/images/mocha.jpg',
      category: 'Latte',
      ingredients: ['Espresso', 'Chocolate', 'Steamed Milk'],
    ),
    Coffee(
      id: '6',
      name: 'Americano',
      description: 'Espresso with hot water',
      price: 3.49,
      imagePath: 'assets/images/americano.jpg',
      category: 'Espresso',
      ingredients: ['Espresso', 'Hot Water'],
    ),
  ];

  List<Coffee> get filteredCoffees {
    if (_selectedCategory == 0) return coffees;
    return coffees.where((coffee) => coffee.category == categories[_selectedCategory]).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Our Menu',
          style: TextStyle(color: AppColors.textLight),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
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
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              itemCount: filteredCoffees.length,
              itemBuilder: (context, index) {
                return CoffeeCard(
                  coffee: filteredCoffees[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductScreen(coffee: filteredCoffees[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}