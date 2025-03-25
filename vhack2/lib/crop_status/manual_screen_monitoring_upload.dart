import 'package:flutter/material.dart';
import 'crop_status_screen.dart';
import 'manual_monitoring_screen_location.dart';

class ManualMonitoringScreen_Upload extends StatefulWidget {
  const ManualMonitoringScreen_Upload({super.key});

  @override
  State<ManualMonitoringScreen_Upload> createState() => _ManualMonitoringScreenState();
}

class _ManualMonitoringScreenState extends State<ManualMonitoringScreen_Upload> {
  String? selectedFileName = '20250325_1.png'; // Placeholder file

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
                  'Manual Monitoring',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: _disabledButton('Upload image'),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: _uploadCard(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _disabledButton(String label) {
    return Container(
      width: 240,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blueGrey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blueGrey),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: Colors.blueGrey[400],
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _uploadCard() {
    return Container(
      width: 340,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Upload photo',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Select and upload the photo of your choice',
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                style: BorderStyle.solid,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Text(
                  'Choose a file to upload',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                const Text(
                  'JPEG, PNG, and JPG formats, up to 50 MB',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black38,
                      style: BorderStyle.values[1],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Browse file',
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          if (selectedFileName != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.image, size: 20),
                  const SizedBox(width: 8),
                  Expanded(child: Text(selectedFileName!)),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFileName = null;
                      });
                    },
                    child: const Icon(Icons.close, size: 18),
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                // Handle Proceed action here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ManualMonitoringResultScreenLocation()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('Proceed'),
            ),
          ]
        ],
      ),
    );
  }
}
