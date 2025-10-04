import '../models/product.dart';

class ProductService {
  static List<Product> getProducts() {
    return [
      Product(
        id: '1',
        name: 'Wireless Headphones',
        description: 'High-quality wireless headphones with noise cancellation',
        price: 99.99,
        imageUrl: 'https://picsum.photos/200/300?random=1',
        stock: 10,
      ),
      Product(
        id: '2',
        name: 'Smart Watch',
        description: 'Feature-rich smartwatch with health monitoring',
        price: 199.99,
        imageUrl: 'https://picsum.photos/200/300?random=2',
        stock: 5,
      ),
      Product(
        id: '3',
        name: 'Laptop Backpack',
        description: 'Durable laptop backpack with multiple compartments',
        price: 49.99,
        imageUrl: 'https://picsum.photos/200/300?random=3',
        stock: 20,
      ),
      Product(
        id: '4',
        name: 'Phone Case',
        description: 'Protective phone case with stylish design',
        price: 19.99,
        imageUrl: 'https://picsum.photos/200/300?random=4',
        stock: 50,
      ),
    ];
  }
}