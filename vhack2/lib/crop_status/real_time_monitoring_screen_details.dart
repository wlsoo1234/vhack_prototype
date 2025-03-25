import 'package:flutter/material.dart';
import 'crop_status_screen.dart';
import '../fertilizer_recommendation_screen.dart';

class RealTimeMonitoringScreenDetails extends StatelessWidget {
  const RealTimeMonitoringScreenDetails({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFfc6d2f), Color(0xFF5b2b0f)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAppBar(context),
                  const SizedBox(height: 10),
                  const Text("Location:    Johor", style: TextStyle(fontSize: 16)),
                  const Text("Farm:          Zone A", style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/plant_image.jpg',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/plant_stage.jpg',
                          height: 80,
                        ),
                        const SizedBox(height: 10),
                        const Text("Current Growth stage", style: TextStyle(fontSize: 16)),
                        const Text(
                          "Flowering",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          "48 days left to\nharvesting",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text("Weed level", style: TextStyle(fontSize: 16)),
                  _weedSlider(),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "The weed vegetation is serious,\ntake action now!",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ),
                  ),
                  const Divider(thickness: 1, color: Colors.white70),
                  const SizedBox(height: 10),
                  const Text("Soil Condition", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Image.asset('assets/soil_crack.jpg', height: 40),
                      const SizedBox(width: 10),
                      const Text("Cracking", style: TextStyle(fontSize: 16)),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text("Take action now!"),
                      )
                    ],
                  ),
                  const SizedBox(height: 20), // replace Spacer() with spacing
                  _actionButton(context, "Back to crop status", Colors.green),
                  const SizedBox(height: 10),
                  _actionButton2(context, "Proceed to fertilizing", Colors.green),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _weedSlider() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            height: 15,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.green, Colors.yellow, Colors.red],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Positioned(
            right: 30,
            child: Column(
              children: const [
                Icon(Icons.circle, size: 16, color: Colors.black),
                Text("Severe", style: TextStyle(fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(BuildContext context, String label, Color color) {
    return Center(
      child: ElevatedButton(
        // onPressed: () {
        //   // Add navigation logic
        // },
        onPressed: () {
          // Handle Next navigation here
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CropStatusScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
        child: Text(label, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  Widget _actionButton2(BuildContext context, String label, Color color) {
    return Center(
      child: ElevatedButton(
        // onPressed: () {
        //   // Add navigation logic
        // },
        onPressed: () {
          // Handle Next navigation here
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FertilizerRecommendationScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
        child: Text(label, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: const Center(
              child: Icon(Icons.arrow_back, color: Colors.brown),
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          'Real-time monitoring',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
