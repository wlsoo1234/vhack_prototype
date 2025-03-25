import 'package:flutter/material.dart';
import 'disease_identification_screen_upload.dart';
import 'manual_screen_monitoring_upload.dart';
import 'real_time_monitoring_screen_upload.dart';

class CropStatusScreen extends StatelessWidget {
  const CropStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE), // Light gray background
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Back button with brown circular background
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF8B4513), // Brown color
                      shape: BoxShape.circle,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'BACK',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Crop Status',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Disease/Pest Identification Button
            _buildOptionButton(
              title: 'Disease/Pest\nIdentification',
              onTap: () {
                // Handle button tap
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DiseaseIdentificationScreen_Upload()),
                );
              },
            ),
            
            const SizedBox(height: 40),
            
            // Real-time camera monitor Button
            _buildOptionButton(
              title: 'Real-time camera monitor',
              onTap: () {
                // Handle button tap
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RealTimeMonitoringScreen_Upload()),
                );
              },
            ),
            
            const SizedBox(height: 40),
            
            // Manual Monitoring Button
            _buildOptionButton(
              title: 'Manual Monitoring',
              onTap: () {
                // Handle button tap
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ManualMonitoringScreen_Upload()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildOptionButton({required String title, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Material(
        color: const Color(0xFF7FE5FF), // Light blue color
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
