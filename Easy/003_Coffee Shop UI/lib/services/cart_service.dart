import '../models/cart_item.dart';

class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0.0;
    for (var item in _items) {
      total += item.totalPrice;
    }
    return total;
  }

  void addItem(CartItem newItem) {
    _items.add(newItem);
  }

  void removeItem(String coffeeId, String size) {
    _items.removeWhere((item) => 
        item.coffee.id == coffeeId && item.size == size);
  }

  void clearCart() {
    _items.clear();
  }

  void updateQuantity(String coffeeId, String size, int newQuantity) {
    final index = _items.indexWhere((item) => 
        item.coffee.id == coffeeId && item.size == size);
    if (index >= 0) {
      _items[index].quantity = newQuantity;
    }
  }
}