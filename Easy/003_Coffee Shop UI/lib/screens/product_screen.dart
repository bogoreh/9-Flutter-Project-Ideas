import 'package:flutter/material.dart';
import '../models/coffee.dart';
import '../models/cart_item.dart';
import '../services/cart_service.dart';
import '../utils/constants.dart';

class ProductScreen extends StatefulWidget {
  final Coffee coffee;

  const ProductScreen({Key? key, required this.coffee}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String selectedSize = 'Regular';
  int quantity = 1;
  String notes = '';
  final CartService cartService = CartService();

  final Map<String, double> sizePrices = {
    'Small': -0.5,
    'Regular': 0.0,
    'Large': 0.5,
  };

  double get totalPrice {
    return (widget.coffee.price + sizePrices[selectedSize]!) * quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          widget.coffee.name,
          style: const TextStyle(color: AppColors.textLight),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                widget.coffee.imagePath,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.coffee.name,
              style: AppTextStyles.headline1,
            ),
            const SizedBox(height: 8),
            Text(
              widget.coffee.description,
              style: AppTextStyles.bodyText,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(
                  '${widget.coffee.rating} (${widget.coffee.ratingCount} reviews)',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Size',
              style: AppTextStyles.headline2,
            ),
            const SizedBox(height: 8),
            Row(
              children: sizePrices.keys.map((size) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: selectedSize == size
                            ? AppColors.primary
                            : Colors.transparent,
                        foregroundColor: selectedSize == size
                            ? AppColors.textLight
                            : AppColors.textDark,
                        side: BorderSide(color: AppColors.primary),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedSize = size;
                        });
                      },
                      child: Text(size),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Text(
              'Ingredients',
              style: AppTextStyles.headline2,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: widget.coffee.ingredients.map((ingredient) {
                return Chip(
                  label: Text(ingredient),
                  backgroundColor: AppColors.accent,
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Text(
              'Special Instructions',
              style: AppTextStyles.headline2,
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'E.g., extra hot, no sugar',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  notes = value;
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Quantity',
                  style: AppTextStyles.headline2,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                ),
                Text(
                  quantity.toString(),
                  style: AppTextStyles.headline2,
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Price',
                      style: AppTextStyles.caption,
                    ),
                    Text(
                      '\$${totalPrice.toStringAsFixed(2)}',
                      style: AppTextStyles.price,
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textLight,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    final cartItem = CartItem(
                      coffee: widget.coffee,
                      quantity: quantity,
                      size: selectedSize,
                      notes: notes.isNotEmpty ? notes : null,
                    );
                    cartService.addItem(cartItem);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${widget.coffee.name} added to cart'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Add to Cart'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}