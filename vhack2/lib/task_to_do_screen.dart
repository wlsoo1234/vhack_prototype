import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskToDoScreen extends StatefulWidget {
  const TaskToDoScreen({super.key});

  @override
  State<TaskToDoScreen> createState() => _TaskToDoScreenState();
}

class _TaskToDoScreenState extends State<TaskToDoScreen> {
  String selectedFarm = 'Johor';
  List<Map<String, dynamic>> tasks = [
    {
      'type': 'Purchasing',
      'date': DateTime(2025, 4, 15),
      'time': TimeOfDay(hour: 12, minute: 30),
      'item': 'Fertilizer',
      'itemName': 'NPK fertilizer',
      'quantity': '20.0 kg',
    },
    {
      'type': 'Fertilizing',
      'date': DateTime(2025, 4, 15),
      'time': TimeOfDay(hour: 15, minute: 30),
      'area': 'Zone A',
      'corp': 'Corn',
      'fertilizer': 'NPK fertilizer',
      'quantity': '1000 gram',
    },
  ];

  final dropdownOptions = {
    'farm': ['Johor', 'Melaka'],
    'taskType': ['Purchasing', 'Fertilizing', 'Watering', 'Monitoring'],
    'item': ['Fertilizer', 'Pesticide'],
    'itemName': ['NPK fertilizer', 'PNK fertilizer'],
    'area': ['Zone A', 'Zone B'],
    'corp': ['Corn', 'Tomato'],
    'fertilizer': ['NPK fertilizer'],
    'quantity': ['20.0 kg', '1000 gram', '500 ml'],
  };

  void _pickDate(int index) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: tasks[index]['date'],
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        tasks[index]['date'] = picked;
      });
    }
  }

  void _pickTime(int index) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: tasks[index]['time'],
    );
    if (picked != null) {
      setState(() {
        tasks[index]['time'] = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              _buildHeader(),
              const SizedBox(height: 10),
              _dropdownField('Farm:', selectedFarm, dropdownOptions['farm']!,
                  (val) => setState(() => selectedFarm = val!)),
              const Divider(thickness: 1),
              ...tasks.asMap().entries.map((entry) {
                int index = entry.key;
                return _buildTaskCard(index);
              }),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  setState(() {
                    tasks.add({
                      'type': 'Select Task',
                      'date': DateTime.now(),
                      'time': TimeOfDay.now(),
                    });
                  });
                },
                child: const Text(
                  'Add new task',
                  style: TextStyle(fontSize: 16),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst); // Go back to home

                  // Delay the SnackBar so it's shown after the navigation completes
                  Future.delayed(const Duration(milliseconds: 300), () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Task saved!'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent[400],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Confirm', style: TextStyle(fontSize: 16)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
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
          'Task-to-do',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildTaskCard(int index) {
    final task = tasks[index];
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _dropdownField('Task ${index + 1}', task['type'],
              dropdownOptions['taskType']!, (val) {
            setState(() => task['type'] = val);
          }),
          const SizedBox(height: 10),
          _dateTimePicker(index),
          if (task['type'] == 'Purchasing') ...[
            _dropdownField('Item:', task['item'], dropdownOptions['item']!,
                (val) => setState(() => task['item'] = val)),
            _dropdownField('Item name:', task['itemName'],
                dropdownOptions['itemName']!, (val) {
              setState(() => task['itemName'] = val);
            }),
            _dropdownField('Quantity:', task['quantity'],
                dropdownOptions['quantity']!, (val) {
              setState(() => task['quantity'] = val);
            }),
          ],
          if (task['type'] == 'Fertilizing') ...[
            _dropdownField('Area:', task['area'], dropdownOptions['area']!,
                (val) => setState(() => task['area'] = val)),
            _dropdownField('Corp:', task['corp'], dropdownOptions['corp']!,
                (val) => setState(() => task['corp'] = val)),
            _dropdownField('Fertilizer:', task['fertilizer'],
                dropdownOptions['fertilizer']!, (val) {
              setState(() => task['fertilizer'] = val);
            }),
            _dropdownField('Quantity:', task['quantity'],
                dropdownOptions['quantity']!, (val) {
              setState(() => task['quantity'] = val);
            }),
          ]
        ],
      ),
    );
  }

  Widget _dropdownField(
      String label, String? value, List<String> items, ValueChanged<String?> onChanged) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(label, style: const TextStyle(fontSize: 14)),
        ),
        Expanded(
          flex: 7,
          child: DropdownButtonFormField<String>(
            value: value,
            items: items
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.amber[100],
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _dateTimePicker(int index) {
    final task = tasks[index];
    final formattedDate = DateFormat('EEEE, yyyy/MM/dd').format(task['date']);
    final formattedTime = task['time'].format(context);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: const Text('Date:'),
            ),
            Expanded(
              flex: 7,
              child: ElevatedButton.icon(
                onPressed: () => _pickDate(index),
                icon: const Icon(Icons.calendar_today, size: 16),
                label: Text(formattedDate),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[100],
                  foregroundColor: Colors.black,
                  alignment: Alignment.centerLeft,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: const Text('Time:'),
            ),
            Expanded(
              flex: 7,
              child: ElevatedButton.icon(
                onPressed: () => _pickTime(index),
                icon: const Icon(Icons.access_time, size: 16),
                label: Text(formattedTime),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[100],
                  foregroundColor: Colors.black,
                  alignment: Alignment.centerLeft,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
