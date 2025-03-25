import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'plant_rotation_screen.dart';
import 'task_detial_screen.dart';
import 'water_screen.dart';
import 'weather_screen.dart';

class HumidityScreen extends StatefulWidget {
  const HumidityScreen({super.key});

  @override
  State<HumidityScreen> createState() => _HumidityScreenState();
}

class _HumidityScreenState extends State<HumidityScreen> {
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

  // 📌 Humidity data for each day
  final Map<int, String> humidityData = {
    1: '40%',
    2: '80%',
    3: '20%',
    4: '52%',
    5: '23%',
    6: '11%',
    7: '47%',
    8: '34%',
    9: '47%',
    10: '12%',
    11: '22%',
    12: '30%',
    13: '40%',
    14: '50%',
    15: '77%',
    16: '21%',
    17: '43%',
    18: '23%',
    19: '32%',
    20: '14%',
    21: '30%',
    22: '20%',
    23: '34%',
    24: '35%',
    25: '47%',
    26: '26%',
    27: '78%',
    28: '32%',
    29: '11%',
    30: '32%',
    31: '14%',
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
            icon: const Icon(Icons.menu), // Toggle task list
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

  /// **📌 Task List View**
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

  /// **📅 Calendar View**
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
              [
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
                        humidityData[day.day] ?? '',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildBottomSection(),
      ],
    );
  }

  /// **📌 Bottom Section (Humidity Details)**
  Widget _buildBottomSection() {
    String humidity = humidityData[_selectedDate.day] ?? 'N/A';

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(224, 224, 224, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_selectedDate.day} Mar',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('Humidity: $humidity', style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 16),

          // ✅ Fixed size grey boxes for better alignment
          _buildGreyBox("🌱 Soil Moisture: Keep soil slightly damp"),
          const SizedBox(height: 8),
          _buildGreyBox("☀️ Sunlight: Moderate sunlight is recommended"),
          const SizedBox(height: 8),
          _buildGreyBox("💨 Ventilation: Ensure good air circulation"),
        ],
      ),
    );
  }

  /// **📌 Grey Box with Fixed Size**
  Widget _buildGreyBox(String text) {
    return Container(
      height: 50, // Fixed height for uniform size
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.left,
      ),
    );
  }

  /// **📌 Task List Item**
  Widget _buildListItem(String title) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontSize: 18)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        _navigateToScreen(title);
      },
    );
  }

  /// **🔹 Navigation Function**
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
      default:
        screen = TaskDetailScreen(taskTitle: title);
        break;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}
