import 'package:flutter/material.dart';
import 'crop_status_screen.dart';
import 'real_time_monitoring_screen_details.dart';

class RealTimeMonitoringScreen_Upload extends StatefulWidget {
  const RealTimeMonitoringScreen_Upload({super.key});

  @override
  State<RealTimeMonitoringScreen_Upload> createState() => _RealTimeMonitoringScreenStateUpload();
}

class _RealTimeMonitoringScreenStateUpload extends State<RealTimeMonitoringScreen_Upload> {
  String selectedFarm = 'Johor';
  String selectedZone = 'Zone A';
  bool useGPS = false;

  final List<String> farms = ['Johor', 'Melaka', 'Selangor'];
  final List<String> zones = ['Zone A', 'Zone B', 'Zone C'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Colors.grey[300],
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Row(
              children: [
                const SizedBox(width: 10),
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
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Farm:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedFarm,
              items: farms
                  .map((farm) =>
                      DropdownMenuItem(value: farm, child: Text(farm)))
                  .toList(),
              onChanged: (value) => setState(() => selectedFarm = value!),
              decoration: _dropdownDecoration(),
            ),
            Row(  
              children: [
                Checkbox(
                  value: useGPS,
                  onChanged: (value) => setState(() => useGPS = value!),
                ),
                const Text('Use current GPS location')
              ],
            ),
            const SizedBox(height: 10),
            const Text('Select Zone:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedZone,
              items: zones
                  .map((zone) =>
                      DropdownMenuItem(value: zone, child: Text(zone)))
                  .toList(),
              onChanged: (value) => setState(() => selectedZone = value!),
              decoration: _dropdownDecoration(),
            ),
            const SizedBox(height: 20),
            Center(child: _mapPlaceholder()),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle Next navigation here
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RealTimeMonitoringScreenDetails()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent[400],
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Next', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _dropdownDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[400],
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _mapPlaceholder() {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/map_sample.jpeg'), // Replace with your asset
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          for (var pos in _cameraDots.entries)
            Positioned(
              left: pos.value.dx,
              top: pos.value.dy,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: pos.key == 'active' ? Colors.red : Colors.red[200],
                  shape: BoxShape.circle,
                ),
              ),
            )
        ],
      ),
    );
  }

  // Hardcoded camera positions for example
  final Map<String, Offset> _cameraDots = {
    '1': Offset(40, 40),
    '2': Offset(180, 50),
    '3': Offset(60, 140),
    '4': Offset(130, 230),
    'active': Offset(220, 140), // Highlighted dot
  };
}
