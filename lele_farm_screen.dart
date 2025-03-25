import 'package:flutter/material.dart';
// import 'weather_screen.dart'; // Import the WeatherScreen
// import 'plant_rotation_screen.dart'; // Import the PlantRotationScreen
import 'waterdata_screen.dart';
// import 'humidity_screen.dart'; // Import the HumidityScreen
// import 'profile_screen.dart'; // Import the ProfileScreen

class LeleFarmScreen extends StatelessWidget {
  const LeleFarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kuala Lumpur'),
        backgroundColor: Colors.grey[300],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current and Archived tabs
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Current',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Archived',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Crops - Lele farm section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Crops - Lele farm',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text('Area: 7743 m²'),
                  const Text('Was Created on 10/3/2024'),
                  const SizedBox(height: 8),
                  Image.network(
                    'https://placehold.co/100x100?text=Crop+Image',
                    width: 100,
                    height: 100,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.agriculture,
                        size: 100,
                        color: Colors.green,
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Status indicators as buttons
            _buildClickableStatusIndicator(
              'Today\'s weather is bad',
              Icons.cloud_off,
              context,
            ),
            _buildClickableStatusIndicator(
              'Today\'s water level is moderate',
              Icons.water_drop,
              context,
            ),
            _buildClickableStatusIndicator(
              'Today\'s soil level is ok',
              Icons.grass,
              context,
            ),
            _buildClickableStatusIndicator(
              'Today\'s pest control level is ok',
              Icons.bug_report,
              context,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: ''),
        ],
        backgroundColor: Colors.white,
        elevation: 5,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Placeholder for map functionality
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.map, size: 30, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  // Helper method to build clickable status indicators
  Widget _buildClickableStatusIndicator(
    String text,
    IconData icon,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        // Navigate to the appropriate screen based on the status indicator tapped
        _navigateToScreen(text, context);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
            Icon(icon, size: 40, color: Colors.blue),
          ],
        ),
      ),
    );
  }

  // Navigation function for status indicators
  void _navigateToScreen(String title, BuildContext context) {
    Widget screen;
    switch (title) {
      // case 'Today\'s weather is bad':
      //   screen =
      //       const WeatherScreen(); // Replace with your actual WeatherScreen
      //   break;
      case 'Today\'s water level is moderate':
        screen = WaterData(); // Replace with your actual WaterScreen
        break;
      // case 'Today\'s soil level is ok':
      //   screen = const SoilScreen(); // Replace with your actual SoilScreen
      //    break;
      //   case 'Today\'s pest control level is ok':
      //     screen =
      //         const PestControlScreen(); // Replace with your actual PestControlScreen
      //      break;
      default:
        screen = const LeleFarmScreen(); // Default to LeleFarmScreen
        break;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}
