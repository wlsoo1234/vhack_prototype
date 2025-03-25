import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'water_screen.dart';
import 'task_detial_screen.dart';
import 'weather_screen.dart';
import 'plant_rotation_screen.dart';
import 'humidity_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
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
          _buildListItem('Plant Rotation'),
          _buildListItem('Water'), // ✅ Water option added
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
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
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

  // Inside _navigateToScreen() function
  void _navigateToScreen(String title) {
    Widget screen;
    switch (title) {
      case 'Weather':
        screen = const WeatherScreen();
        break;
      case 'Plant Rotation':
        screen = const PlantRotation();
        break;
      case 'Water':
        screen = const WaterScreen();
        break;
      case 'Humidity': // ✅ New case for humidity
        screen = const HumidityScreen();
        break;
      default:
        screen = TaskDetailScreen(taskTitle: title);
        break;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}
