import 'coffee.dart';

class CartItem {
  final Coffee coffee;
  int quantity;
  final String size;
  final String? notes;

  CartItem({
    required this.coffee,
    this.quantity = 1,
    required this.size,
    this.notes,
  });

  double get totalPrice => coffee.price * quantity;
}