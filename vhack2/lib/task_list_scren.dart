import 'package:flutter/material.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        backgroundColor: Colors.grey[300],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Handle menu button press
          },
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildListItem('Task to do'),
            _buildListItem('Weather'),
            _buildListItem('Plant Rotation'),
            _buildListItem('Water'),
            _buildListItem('Humidity'),
          ],
        ),
      ),
    );
  }

  // Helper method to build list items
  Widget _buildListItem(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(title, style: const TextStyle(fontSize: 18)),
    );
  }
}
