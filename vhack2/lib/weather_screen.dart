import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart'; // Keep this import as it is used for the calendar
import 'plant_rotation_screen.dart';
import 'task_detial_screen.dart';
import 'water_screen.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late DateTime _selectedDate;
  late DateTime _focusedDate;
  String _selectedLocation = 'Kuala Lumpur';
  bool _showTasks = false; // Toggle between calendar & task list

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now(); // Set to current date
    _focusedDate = DateTime.now();
  }

  // Static weather data based on the provided image
  final Map<int, String> weatherData = {
    1: '☀️',
    2: '🌧️',
    3: '☀️', // Current day
    4: '☀️',
    5: '',
    6: '🌥️',
    7: '🌥️',
    8: '',
    9: '☀️',
    10: '☀️',
    11: '',
    12: '🌥️',
    13: '🌱',
    14: '',
    15: '🌥️',
    16: '',
    17: '🌥️',
    18: '🌧️',
    19: '⛈️',
    20: '',
    21: '☀️',
    22: '🌥️',
    23: '☀️',
    24: '',
    25: '☀️', // Today's weather
    26: '🌧️',
    27: '',
    28: '🌧️',
    29: '',
    30: '🌧️',
    31: '',
  };

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
            icon: const Icon(Icons.menu), // Menu button for task list
            onPressed: () {
              setState(() {
                _showTasks = !_showTasks; // Toggle task list
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

  /// 🌱 **Task List View**
  Widget _buildTaskList() {
    return Container(
      color: Colors.grey[200],
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildListItem('Task to do'),
          _buildListItem('Plant Rotation'),
          _buildListItem('Watering Schedule'),
          _buildListItem('Humidity'),
        ],
      ),
    );
  }

  /// 📅 **Calendar View**
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
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${day.day}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        weatherData[day.day] ?? '',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 20), // Space between calendar and weather info
        _buildWeatherInfo(), // New weather info section
      ],
    );
  }

  /// **Weather Info Section**
  Widget _buildWeatherInfo() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.wb_sunny, size: 50, color: Colors.yellow),
              const SizedBox(width: 10),
              Text(
                '${_selectedDate.day} Mar', // Dynamically display the selected date
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 100, // Height for the notes area
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            child: const Center(
              child: Text(
                'Additional weather details or notes can go here.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Robot recommendation section
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            child: const Text(
              '🤖 Recommendation: It\'s a sunny day! Great for outdoor activities like a picnic or a walk in the park.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
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
      case 'Water':
        screen = const WaterScreen(); // ✅ Navigates to WaterScreen
        break;
      default:
        screen = TaskDetailScreen(taskTitle: title);
        break;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}
