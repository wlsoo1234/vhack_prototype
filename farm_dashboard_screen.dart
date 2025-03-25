import 'package:flutter/material.dart';
import 'setting_screen.dart';
import 'profile_screen.dart';
import 'crops_info_screen.dart';
import 'calendar_screen.dart';
import 'lele_farm_screen.dart';
import 'chatbot_screen.dart';

class FarmDashboardScreen extends StatefulWidget {
  const FarmDashboardScreen({super.key});

  @override
  State<FarmDashboardScreen> createState() => _FarmDashboardScreenState();
}

class _FarmDashboardScreenState extends State<FarmDashboardScreen> {
  // List to store crop entries
  List<Map<String, String>> _crops = [
    {
      'name': 'Kuala Lumpur',
      'imageUrl': 'https://placehold.co/50x50?text=KL+Farm',
    },
    {
      'name': 'Johor Bahru',
      'imageUrl': 'https://placehold.co/50x50?text=JB+Farm',
    },
    {
      'name': 'Melaka',
      'imageUrl': 'https://placehold.co/50x50?text=Melaka+Farm',
    },
    {
      'name': 'Kelantan',
      'imageUrl': 'https://placehold.co/50x50?text=Kelantan+Farm',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Welcome header with avatar
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            color: Colors.grey[300],
            child: SafeArea(
              bottom: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Welcome',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  // Circular avatar wrapped in GestureDetector
                  GestureDetector(
                    onTap: () {
                      // Navigate to profile screen when clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(
                          0xFFE57C45,
                        ), // Orange/brown color as in the image
                      ),
                      child: ClipOval(
                        child: Image.network(
                          'https://placehold.co/40x40?text=User',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.person,
                              color: Colors.white,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Main content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Your Farms title
                  const Text(
                    'Your Farms',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),

                  // Farm entries
                  Expanded(
                    child: ListView.builder(
                      itemCount: _crops.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            _buildFarmEntry(
                              _crops[index]['name']!,
                              _crops[index]['imageUrl']!,
                            ),
                            const SizedBox(height: 12),
                          ],
                        );
                      },
                    ),
                  ),

                  const Spacer(), // Push the floating icons to the bottom
                  // Floating icons above the bottom navigation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Image.network(
                            'https://placehold.co/24x24?text=Calendar',
                            width: 24,
                            height: 24,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.calendar_today, size: 20);
                            },
                          ),
                          onPressed: () {
                            // Navigate to calendar screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CalendarScreen(),
                              ),
                            );
                          },
                          padding: EdgeInsets.zero,
                          iconSize: 24,
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Image.network(
                            'https://placehold.co/24x24?text=Robot',
                            width: 24,
                            height: 24,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.smart_toy, size: 20);
                            },
                          ),
                          onPressed: () {
                            // Navigate to chat bot screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ChatBotScreen(),
                              ),
                            );
                          },
                          padding: EdgeInsets.zero,
                          iconSize: 24,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20), // Space before bottom navigation
                ],
              ),
            ),
          ),

          // Bottom navigation with large center button
          Container(
            height: 60,
            color: Colors.grey[300],
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Bottom navigation bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Settings icon
                    IconButton(
                      icon: const Icon(Icons.settings, color: Colors.black),
                      onPressed: () {
                        // Navigate to settings screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsScreen(),
                          ),
                        );
                      },
                    ),

                    // Placeholder for center button
                    const SizedBox(width: 60),

                    // Chatbot icon
                    IconButton(
                      icon: Image.network(
                        'https://placehold.co/24x24?text=Robot',
                        width: 24,
                        height: 24,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.smart_toy,
                            color: Colors.black,
                          );
                        },
                      ),
                      onPressed: () {
                        // Navigate to chat bot screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChatBotScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                // Large center button
                Positioned(
                  child: Container(
                    width: 40, // Set the same size as other buttons
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        // Navigate to crop entry screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => CropEntryScreen(
                                  onCropAdded: (cropName) {
                                    setState(() {
                                      _crops.add({
                                        'name': cropName,
                                        'imageUrl':
                                            'https://placehold.co/50x50?text=$cropName+Farm',
                                      });
                                    });
                                  },
                                ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build farm entries
  Widget _buildFarmEntry(String name, String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFA5FFC7), // Light green color as in the image
        borderRadius: BorderRadius.circular(25),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {
            if (name == 'Kuala Lumpur') {
              // Navigate to Lele Farm screen when Kuala Lumpur is clicked
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LeleFarmScreen()),
              );
            }
            // Handle other farm entry taps if needed
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Row(
              children: [
                // Farm image
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipOval(
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.landscape,
                          size: 30,
                          color: Colors.green,
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Farm name
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
