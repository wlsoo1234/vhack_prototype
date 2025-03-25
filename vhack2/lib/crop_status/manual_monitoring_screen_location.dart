import 'package:flutter/material.dart';
import 'manual_monitoring_screen_details.dart';

class ManualMonitoringResultScreenLocation extends StatefulWidget {
  const ManualMonitoringResultScreenLocation({super.key});

  @override
  State<ManualMonitoringResultScreenLocation> createState() =>
      _ManualMonitoringResultScreenState();
}

class _ManualMonitoringResultScreenState extends State<ManualMonitoringResultScreenLocation> {
  String plantName = 'Corn';
  String? selectedLocation;
  bool useGPS = false;

  final List<String> locations = ['Zone A', 'Zone B', 'Zone C'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFe9a55c), Color(0xFF8f4f15)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppBar(context),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/weed_detection_result.jpg', // Replace with your actual image
                    // height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Enter information about the plant',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Text('Plant Name:', style: TextStyle(fontSize: 14)),
                const SizedBox(height: 4),
                TextFormField(
                  initialValue: plantName,
                  onChanged: (value) => setState(() => plantName = value),
                  decoration: _inputDecoration(),
                ),
                const SizedBox(height: 16),
                const Text('Select Location:', style: TextStyle(fontSize: 14)),
                const SizedBox(height: 4),
                DropdownButtonFormField<String>(
                  value: selectedLocation,
                  items: locations
                      .map((loc) => DropdownMenuItem(value: loc, child: Text(loc)))
                      .toList(),
                  onChanged: (value) => setState(() => selectedLocation = value),
                  decoration: _inputDecoration(),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Checkbox(
                      value: useGPS,
                      onChanged: (value) => setState(() => useGPS = value!),
                    ),
                    const Text('Use current GPS location'),
                  ],
                ),
                const Spacer(),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ManualMonitoringScreenDetails()),
                        );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent[400],
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Next', style: TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.cyanAccent,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
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
          'Manual Monitoring',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
