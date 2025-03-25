import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'plant_rotation_screen.dart';
import 'task_detial_screen.dart';
import 'water_screen.dart';
import 'weather_screen.dart';

class HumidityScreen extends StatefulWidget {
  const HumidityScreen({super.key});

  @override
  State<HumidityScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<HumidityScreen> {
  late DateTime _selectedDate;
  late DateTime _focusedDate;
  String _selectedLocation = 'Kuala Lumpur';
  bool _showTasks = false; // Toggle between calendar & task list

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _focusedDate = DateTime.now();
  }

  // Updated percentage-based weather data
  final Map<int, String> weatherData = {
    1: '40%',
    2: '60%',
    3: '34%',
    4: '47%',
    5: '77%',
    6: '21%',
    7: '20%',
    8: '34%',
    9: '1%',
    10: '32%',
    11: '20%',
    12: '52%',
    13: '23%',
    14: '12%',
    15: '22%',
    16: '30%',
    17: '43%',
    18: '23%',
    19: '32%',
    20: '37%',
    21: '41%',
    22: '26%',
    23: '14%',
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
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                );
              },
            ),
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
