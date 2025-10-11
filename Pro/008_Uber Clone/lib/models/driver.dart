class Driver {
  final String id;
  final String name;
  final String carModel;
  final String licensePlate;
  final double rating;
  final String imageUrl;
  final double distance;

  Driver({
    required this.id,
    required this.name,
    required this.carModel,
    required this.licensePlate,
    required this.rating,
    required this.imageUrl,
    required this.distance,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'carModel': carModel,
      'licensePlate': licensePlate,
      'rating': rating,
      'imageUrl': imageUrl,
      'distance': distance,
    };
  }

  factory Driver.fromMap(Map<String, dynamic> map) {
    return Driver(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      carModel: map['carModel'] ?? '',
      licensePlate: map['licensePlate'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      imageUrl: map['imageUrl'] ?? '',
      distance: map['distance']?.toDouble() ?? 0.0,
    );
  }
}