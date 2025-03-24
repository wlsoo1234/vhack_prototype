import 'package:flutter/material.dart';

class TaskDetailScreen extends StatefulWidget {
  final String taskTitle;

  const TaskDetailScreen({super.key, required this.taskTitle});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  // List of highlighted dates
  final List<int> _highlightedDates = [9, 13, 25];
  int _selectedDate = 9; // Default selected date

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        backgroundColor: Colors.grey[300],
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Month and location dropdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'March',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: 'Kuala Lumpur',
                  onChanged: (String? newValue) {
                    // Handle location change
                  },
                  items:
                      <String>[
                        'Kuala Lumpur',
                        'Johor Bahru',
                        'Melaka',
                        'Kelantan',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Days of the week header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Expanded(child: Center(child: Text('Mon'))),
                Expanded(child: Center(child: Text('Tue'))),
                Expanded(child: Center(child: Text('Wed'))),
                Expanded(child: Center(child: Text('Thu'))),
                Expanded(child: Center(child: Text('Fri'))),
                Expanded(child: Center(child: Text('Sat'))),
                Expanded(child: Center(child: Text('Sun'))),
              ],
            ),
            const SizedBox(height: 8),

            // Calendar grid
            Expanded(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1.0,
                ),
                itemCount: 31, // Days in March
                itemBuilder: (context, index) {
                  // Day number (1-31)
                  int day = index + 1;

                  // Check if this date is highlighted
                  bool isHighlighted = _highlightedDates.contains(day);

                  return GestureDetector(
                    onTap: () {
                      if (isHighlighted) {
                        setState(() {
                          _selectedDate = day;
                        });
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color:
                            isHighlighted ? Colors.red[400] : Colors.grey[300],
                      ),
                      child: Center(
                        child: Text(
                          '$day',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                                isHighlighted
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Divider with selected date
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                '$_selectedDate Mar',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const Divider(height: 1, thickness: 1),

            // Task detail area
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Red box
                  Container(width: 40, height: 40, color: Colors.red[400]),
                  const SizedBox(width: 16),
                  // Detail area
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'Details for ${widget.taskTitle} on $_selectedDate Mar',
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Character icon and detail area
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Character icon
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: Image.network(
                      'https://placehold.co/40x40?text=🌱',
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.eco,
                          size: 30,
                          color: Colors.green,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Detail area
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
