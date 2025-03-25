import 'package:flutter/material.dart';
import 'task_to_do_screen.dart';

class FertilizerRecommendationScreen extends StatelessWidget {
  const FertilizerRecommendationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildAppBar(context),
              const SizedBox(height: 20),
              _infoSection(
                title: 'Suggest Fertilizer',
                content:
                    'Consider using a balanced NPK fertilizer with a focus on potassium (K)',
              ),
              const SizedBox(height: 20),
              _infoSection(
                title: 'Available Fertilizer in the area',
                content:
                    'YaraMila Potassium located at A\nHaifa Group located at B\nVigo Hibong located at C',
              ),
              const SizedBox(height: 20),
              _infoSection(
                title: 'Fertilizer you have bought',
                content: '1. PNK Fertilizer (60% potassium, 30% other nutrient)',
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  // Add to to-do action
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const TaskToDoScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent[400],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Add to task-to-do',
                  style: TextStyle(fontSize: 16),
                ),
              ),
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
            child: const Center(
              child: Icon(Icons.arrow_back, color: Colors.brown),
            ),
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

  Widget _infoSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(12)),
          ),
          child: Text(
            content,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
