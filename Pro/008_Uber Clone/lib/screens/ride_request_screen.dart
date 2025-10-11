import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../models/driver.dart';
import '../models/ride.dart';
import '../services/location_service.dart';
import '../services/ride_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/ride_type_card.dart';
import '../widgets/driver_card.dart';
import 'ride_confirmation_screen.dart';

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
    {
      'type': 'UberX',
      'description': 'Affordable, everyday rides',
      'price': '15.80',
      'time': '5',
    },
    {
      'type': 'Uber Comfort',
      'description': 'Newer cars with extra legroom',
      'price': '20.54',
      'time': '7',
    },
    {
      'type': 'Uber Black',
      'description': 'Premium rides in luxury cars',
      'price': '31.60',
      'time': '3',
    },
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

  void _requestRide(Driver driver) async {
    final ride = await RideService.requestRide(
      pickup: _pickupController.text,
      destination: _destinationController.text,
      rideType: selectedRideType!,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RideConfirmationScreen(
          ride: ride,
          driver: driver,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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
                      const Icon(Icons.radio_button_checked, color: AppColors.accent, size: 20),
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
                    color: AppColors.textPrimary,
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
                      color: AppColors.textPrimary,
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