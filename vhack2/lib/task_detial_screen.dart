import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'plant_rotation_screen.dart';
import 'weather_screen.dart'; // Updated: Weather screen added
import 'water_screen.dart';
import 'humidity_screen.dart';

class TaskDetailScreen extends StatefulWidget {
  final String taskTitle;

  const TaskDetailScreen({super.key, required this.taskTitle});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  String _selectedLocation = 'Kuala Lumpur';
  late DateTime _selectedDate;
  late DateTime _focusedDate;
  bool _showTasks = false;

  final List<int> _highlightedDates = [9, 13, 25]; // Highlighted dates

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _focusedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedLocation),
        backgroundColor: Colors.grey[300],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              setState(() {
                _showTasks = !_showTasks;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _showTasks ? _buildTaskList() : _buildCalendar(),
      ),
    );
  }

  Widget _buildTaskList() {
    return Container(
      color: Colors.grey[200],
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildListItem('Weather'),
          _buildListItem('Plant Rotation'),
          _buildListItem('Watering Schedule'),
          _buildListItem('Humidity'),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'March',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        DropdownButton<String>(
          value: _selectedLocation,
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedLocation = newValue;
              });
            }
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
        Expanded(
          child: TableCalendar<DateTime>(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDate,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDate, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
                _focusedDate = focusedDay;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDate = focusedDay;
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              defaultDecoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
            eventLoader: (day) {
              return _highlightedDates.contains(day.day) ? [day] : [];
            },
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildBottomSection(), // ✅ Added the new bottom UI
      ],
    );
  }

  Widget _buildBottomSection() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            '${_selectedDate.day} March\n remember to water the plant', // Shows selected date
            style: const TextStyle(fontSize: 18, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
          ),
          child: const Text(
            '🤖 Recommendation: Ensure your plants are well-watered today!',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }

  Widget _buildListItem(String title) {
    return GestureDetector(
      onTap: () {
        _navigateToScreen(title); // ✅ Call function to navigate
      },
      child: Container(
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
      ),
    );
  }

  /// **🔹 Navigation Function**
  void _navigateToScreen(String title) {
    Widget screen;
    switch (title) {
      case 'Weather':
        screen = const WeatherScreen(); // Navigates to WeatherScreen
        break;
      case 'Plant Rotation':
        screen = const PlantRotation(); // Navigates to Plant Rotation
        break;
      case 'Humidity':
        screen = const HumidityScreen(); // ✅ Navigates to HumidityScreen
        break;
      default:
        screen = const WaterScreen();
        break;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}
