import '../models/driver.dart';
import '../models/ride.dart';

class RideService {
  static Future<List<Driver>> findNearbyDrivers() async {
    await Future.delayed(const Duration(seconds: 2));
    
    return [
      Driver(
        id: '1',
        name: 'John Smith',
        carModel: 'Toyota Camry',
        licensePlate: 'ABC123',
        rating: 4.8,
        imageUrl: 'https://via.placeholder.com/100',
        distance: 0.8,
      ),
      Driver(
        id: '2',
        name: 'Sarah Johnson',
        carModel: 'Honda Accord',
        licensePlate: 'XYZ789',
        rating: 4.9,
        imageUrl: 'https://via.placeholder.com/100',
        distance: 1.2,
      ),
    ];
  }

  static Future<Ride> requestRide({
    required String pickup,
    required String destination,
    required String rideType,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    
    return Ride(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      pickupAddress: pickup,
      destinationAddress: destination,
      distance: 5.2,
      price: calculatePrice(rideType, 5.2),
      rideType: rideType,
      requestTime: DateTime.now(),
    );
  }

  static double calculatePrice(String rideType, double distance) {
    const baseFare = 2.0;
    const perMileRate = 1.5;
    
    switch (rideType) {
      case 'UberX':
        return baseFare + (distance * perMileRate);
      case 'Uber Comfort':
        return baseFare + (distance * perMileRate * 1.3);
      case 'Uber Black':
        return baseFare + (distance * perMileRate * 2.0);
      default:
        return baseFare + (distance * perMileRate);
    }
  }
}