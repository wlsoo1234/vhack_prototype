import 'package:flutter/material.dart';
import '../fertilizer_recommendation_screen.dart';
import 'crop_status_screen.dart';

class DiseaseResultStructuredScreen extends StatelessWidget {
  const DiseaseResultStructuredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildAppBar(context),
              const SizedBox(height: 16),

              // 📸 Detection Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/disease_detected.jpg', // Replace with actual image
                  width: double.infinity,
                  // height: 240,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                'A disease found!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
              ),
              const SizedBox(height: 16),

              // 🦠 Disease Details Grid
              _infoRow(label: 'Disease', content: 'Northern Leaf Blight\n(Exserohilum turcicum)'),
              const SizedBox(height: 12),
              _infoRow(label: 'Symptoms', content: '''
• Long, cigar-shaped grayish or tan lesions on leaves
• Lesions may merge, causing large areas of dead tissue
• Reduced photosynthesis and yield loss if severe'''),
              const SizedBox(height: 12),
              _infoRow(label: 'Strategies', content: '''
• Apply fungicides like azoxystrobin or propiconazole early in disease development (based on local guidelines).
• Ensure good air flow to reduce humidity around plants'''),

              const SizedBox(height: 24),

              // ℹ️ More Info Box
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'More about Acacia Gall Rust',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              _infoBox('''
• A rust fungus that forms galls on over 100 species of Acacia and related genera, including Falcataria moluccana.

• This fungus is present in Malaysia and can cause significant deformities in affected trees.
              '''),

              const SizedBox(height: 24),

              // ✅ Navigation Buttons
              _greenButton('Back to crop status', () {
                  // Add to to-do action
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CropStatusScreen()));
                },
              ),
              const SizedBox(height: 10),
              _greenButton('Proceed to fertilizing', () {
                // Handle proceed
                Navigator.push(context, MaterialPageRoute(builder: (context) => const FertilizerRecommendationScreen()));
              }),
            ],
          ),
        ),
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
            child: const Icon(Icons.arrow_back, color: Colors.brown),
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          'Disease/Pest Identification',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _infoRow({required String label, required String content}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(content.trim()),
          ),
        ],
      ),
    );
  }

  Widget _infoBox(String content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(content.trim()),
    );
  }

  Widget _greenButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.greenAccent[400],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      ),
      child: Text(label, style: const TextStyle(fontSize: 16)),
    );
  }

  Widget _greenButton2(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.greenAccent[400],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      ),
      child: Text(label, style: const TextStyle(fontSize: 16)),
    );
  }
}
