import 'package:flutter/material.dart';

void main() {
  runApp(const UberCloneApp());
}

// Simple data models
class Driver {
  final String id;
  final String name;
  final String carModel;
  final String licensePlate;
  final double rating;
  final double distance;

  Driver({
    required this.id,
    required this.name,
    required this.carModel,
    required this.licensePlate,
    required this.rating,
    required this.distance,
  });
}

class RideRequest {
  final String pickup;
  final String destination;
  final String rideType;
  final double price;

  RideRequest({
    required this.pickup,
    required this.destination,
    required this.rideType,
    required this.price,
  });
}

// Mock services
class LocationService {
  static Future<String> getCurrentAddress() async {
    await Future.delayed(const Duration(seconds: 1));
    return '123 Main Street, New York, NY';
  }

  static Future<List<String>> searchPlaces(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final places = [
      'Times Square, New York, NY',
      'Central Park, New York, NY',
      'Empire State Building, New York, NY',
      'Brooklyn Bridge, New York, NY',
    ];
    return places.where((place) => place.toLowerCase().contains(query.toLowerCase())).toList();
  }
}

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
        distance: 0.8,
      ),
      Driver(
        id: '2',
        name: 'Sarah Johnson',
        carModel: 'Honda Accord',
        licensePlate: 'XYZ789',
        rating: 4.9,
        distance: 1.2,
      ),
    ];
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

// Custom Widgets
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}

class RideTypeCard extends StatelessWidget {
  final String type;
  final String description;
  final String price;
  final String time;
  final bool isSelected;
  final VoidCallback onTap;

  const RideTypeCard({
    super.key,
    required this.type,
    required this.description,
    required this.price,
    required this.time,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: isSelected ? Colors.green.withOpacity(0.1) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? Colors.green : Colors.grey.shade200,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$$price',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$time min',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DriverCard extends StatelessWidget {
  final Driver driver;

  const DriverCard({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person, size: 30, color: Colors.green),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        driver.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        driver.carModel,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        driver.licensePlate,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          driver.rating.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${driver.distance} mi away',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.green.withOpacity(0.3)],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Screens
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentAddress = 'Fetching location...';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final address = await LocationService.getCurrentAddress();
    setState(() {
      currentAddress = address;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Current Location',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            Text(
              currentAddress,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.green, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Where to?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Enter your destination',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: 'Set destination on map',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RideRequestScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
                children: [
                  _buildServiceCard('Ride', Icons.directions_car, Colors.green),
                  _buildServiceCard('Package', Icons.inventory_2, Colors.blue),
                  _buildServiceCard('Reserve', Icons.calendar_today, Colors.orange),
                  _buildServiceCard('Rentals', Icons.beach_access, Colors.purple),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(String title, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          if (title == 'Ride') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RideRequestScreen(),
              ),
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RideRequestScreen extends StatefulWidget {
  const RideRequestScreen({super.key});

  @override
  State<RideRequestScreen> createState() => _RideRequestScreenState();
}

class _RideRequestScreenState extends State<RideRequestScreen> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  List<String> searchResults = [];
  bool isSearching = false;
  String? selectedRideType;
  List<Driver> nearbyDrivers = [];
  bool isLoadingDrivers = false;

  final List<Map<String, dynamic>> rideTypes = [
    {'type': 'UberX', 'description': 'Affordable, everyday rides', 'price': '15.80', 'time': '5'},
    {'type': 'Uber Comfort', 'description': 'Newer cars with extra legroom', 'price': '20.54', 'time': '7'},
    {'type': 'Uber Black', 'description': 'Premium rides in luxury cars', 'price': '31.60', 'time': '3'},
  ];

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    final address = await LocationService.getCurrentAddress();
    setState(() {
      _pickupController.text = address;
    });
  }

  void _onDestinationChanged(String value) async {
    if (value.length > 2) {
      setState(() {
        isSearching = true;
      });
      
      final results = await LocationService.searchPlaces(value);
      setState(() {
        searchResults = results;
        isSearching = false;
      });
    } else {
      setState(() {
        searchResults.clear();
      });
    }
  }

  void _findDrivers() async {
    if (_destinationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a destination')),
      );
      return;
    }

    if (selectedRideType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a ride type')),
      );
      return;
    }

    setState(() {
      isLoadingDrivers = true;
    });

    final drivers = await RideService.findNearbyDrivers();
    
    setState(() {
      nearbyDrivers = drivers;
      isLoadingDrivers = false;
    });
  }

  void _requestRide(Driver driver) {
    final rideRequest = RideRequest(
      pickup: _pickupController.text,
      destination: _destinationController.text,
      rideType: selectedRideType!,
      price: RideService.calculatePrice(selectedRideType!, 5.2),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RideConfirmationScreen(
          rideRequest: rideRequest,
          driver: driver,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Request a Ride'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Location Inputs
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.radio_button_checked, color: Colors.green, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _pickupController,
                          decoration: const InputDecoration(
                            hintText: 'Pickup location',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.red, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _destinationController,
                          decoration: const InputDecoration(
                            hintText: 'Where to?',
                            border: InputBorder.none,
                          ),
                          onChanged: _onDestinationChanged,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Search Results
            if (isSearching)
              const Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              )
            else if (searchResults.isNotEmpty)
              ...searchResults.map((result) => ListTile(
                leading: const Icon(Icons.location_on_outlined),
                title: Text(result),
                onTap: () {
                  setState(() {
                    _destinationController.text = result;
                    searchResults.clear();
                  });
                },
              )),

            const SizedBox(height: 24),

            // Ride Types
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choose a ride',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                ...rideTypes.map((ride) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: RideTypeCard(
                    type: ride['type'],
                    description: ride['description'],
                    price: ride['price'],
                    time: ride['time'],
                    isSelected: selectedRideType == ride['type'],
                    onTap: () {
                      setState(() {
                        selectedRideType = ride['type'];
                      });
                    },
                  ),
                )),
              ],
            ),

            const SizedBox(height: 24),

            // Find Drivers Button
            CustomButton(
              text: 'Find Drivers',
              onPressed: _findDrivers,
            ),

            const SizedBox(height: 24),

            // Nearby Drivers
            if (isLoadingDrivers)
              const Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              )
            else if (nearbyDrivers.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Available Drivers',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...nearbyDrivers.map((driver) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: DriverCard(
                      driver: driver,
                    ),
                  )),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Request ${selectedRideType}',
                    onPressed: () => _requestRide(nearbyDrivers.first),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pickupController.dispose();
    _destinationController.dispose();
    super.dispose();
  }
}

class RideConfirmationScreen extends StatelessWidget {
  final RideRequest rideRequest;
  final Driver driver;

  const RideConfirmationScreen({
    super.key,
    required this.rideRequest,
    required this.driver,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Ride Confirmed'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 80,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Ride Confirmed!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your ${rideRequest.rideType} is on the way',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Driver Info
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.person, size: 30, color: Colors.green),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                driver.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                driver.carModel,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                driver.licensePlate,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 20),
                                const SizedBox(width: 4),
                                Text(
                                  driver.rating.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${driver.distance} mi away',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Ride Details
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        _buildRideDetail('From', rideRequest.pickup, Icons.radio_button_checked),
                        const SizedBox(height: 16),
                        _buildRideDetail('To', rideRequest.destination, Icons.location_on),
                        const SizedBox(height: 16),
                        const Divider(),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '\$${rideRequest.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Action Buttons
            Column(
              children: [
                CustomButton(
                  text: 'Contact Driver',
                  onPressed: () {
                    // Implement contact functionality
                  },
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text(
                    'Cancel Ride',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRideDetail(String title, String subtitle, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.green, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class UberCloneApp extends StatelessWidget {
  const UberCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uber Clone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}