import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'task_detial_screen.dart';
import 'weather_screen.dart'; // Updated: Weather screen added
import 'water_screen.dart';
import 'humidity_screen.dart';

class PlantRotation extends StatefulWidget {
  const PlantRotation({super.key});

  @override
  State<PlantRotation> createState() => _PlantRotationState();
}

class _PlantRotationState extends State<PlantRotation> {
  late DateTime _selectedDate;
  late DateTime _focusedDate;
  bool _showTasks = false;
  String _selectedLocation = 'Kuala Lumpur';

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
          _buildListItem('Task to do'),
          _buildListItem('Weather'),
          _buildListItem('Water'),
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
          child: TableCalendar(
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
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: _getDayColor(day.day),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildLegend(), // ✅ New: Legend added here
      ],
    );
  }

  /// **🌱 Function to Determine Color Based on Day**
  Color _getDayColor(int day) {
    if (day >= 1 && day <= 7) {
      return Colors.green; // Tomato
    } else if (day >= 8 && day <= 21) {
      return Colors.red; // Rice
    } else if (day >= 22 && day <= 31) {
      return Colors.grey; // Soybean
    }
    return Colors.transparent;
  }

  /// **📌 Legend Section**
  Widget _buildLegend() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _legendItem(Colors.green, "Tomato"),
            const SizedBox(width: 16),
            _legendItem(Colors.red, "Rice"),
            const SizedBox(width: 16),
            _legendItem(Colors.grey, "Soybean"),
          ],
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

  /// **📌 Helper Widget for Legend**
  Widget _legendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 16)),
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
        screen = const WaterScreen();
        break;
      case 'Humidity':
        screen = const HumidityScreen(); //✅ Navigates to WaterScreen
        break;
      default:
        screen = TaskDetailScreen(taskTitle: title);
        break;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}
