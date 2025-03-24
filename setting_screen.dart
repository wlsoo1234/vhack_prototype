import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool priorityNotifications = true;
  bool priorityNotifications2 = true;

  // Checkboxes for different alert types
  final List<bool> importantAlerts = [false, false, false, false];
  final List<bool> mediumAlerts = [false, false, false, false];
  final List<bool> notImportantAlerts = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Welcome'),
        backgroundColor: Colors.grey[300],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Setting title
                    const Center(
                      child: Text(
                        'Setting',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Priority Notifications section
                    _buildSettingSection(
                      'Priority Notifications',
                      'This allow the app to notify you on the weather, and other news',
                      isToggle: true,
                      toggleValue: priorityNotifications,
                      onToggleChanged: (value) {
                        setState(() {
                          priorityNotifications = value;
                        });
                      },
                    ),

                    const SizedBox(height: 15),

                    // Important Alerts section
                    _buildSettingSection(
                      'Important Alerts',
                      '',
                      isCheckboxGrid: true,
                      checkboxValues: importantAlerts,
                      onCheckboxChanged: (index, value) {
                        setState(() {
                          importantAlerts[index] = value;
                        });
                      },
                    ),

                    const SizedBox(height: 15),

                    // Medium Alerts section
                    _buildSettingSection(
                      'Medium Alerts',
                      '',
                      isCheckboxGrid: true,
                      checkboxValues: mediumAlerts,
                      onCheckboxChanged: (index, value) {
                        setState(() {
                          mediumAlerts[index] = value;
                        });
                      },
                    ),

                    const SizedBox(height: 15),

                    // Not Really Important Alerts section
                    _buildSettingSection(
                      'Not Really Important Alerts',
                      '',
                      isCheckboxGrid: true,
                      checkboxValues: notImportantAlerts,
                      onCheckboxChanged: (index, value) {
                        setState(() {
                          notImportantAlerts[index] = value;
                        });
                      },
                    ),

                    const SizedBox(height: 15),

                    // Second Priority Notifications section
                    _buildSettingSection(
                      'Priority Notifications',
                      'This allow the app to notify you on the weather, and other news',
                      isToggle: true,
                      toggleValue: priorityNotifications2,
                      onToggleChanged: (value) {
                        setState(() {
                          priorityNotifications2 = value;
                        });
                      },
                    ),

                    const SizedBox(height: 15),

                    // Bluetooth Devices section
                    _buildSettingSection(
                      'Bluetooth Devices',
                      '',
                      isEmpty: true,
                    ),

                    const SizedBox(height: 20),

                    // Update button
                    Center(
                      child: SizedBox(
                        width: 120,
                        child: OutlinedButton(
                          onPressed: () {
                            // Handle update
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.black),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text(
                            'Update',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build setting sections
  Widget _buildSettingSection(
    String title,
    String subtitle, {
    bool isToggle = false,
    bool toggleValue = false,
    Function(bool)? onToggleChanged,
    bool isCheckboxGrid = false,
    List<bool>? checkboxValues,
    Function(int, bool)? onCheckboxChanged,
    bool isEmpty = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isToggle)
                Switch(
                  value: toggleValue,
                  onChanged: onToggleChanged,
                  activeColor: const Color(0xFF4AEDC4), // Teal/mint green color
                  activeTrackColor: const Color(0xFFB0F5E5),
                ),
            ],
          ),
          if (subtitle.isNotEmpty)
            Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
          if (isCheckboxGrid)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildCheckbox(0, checkboxValues!, onCheckboxChanged!),
                      _buildCheckbox(1, checkboxValues, onCheckboxChanged),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildCheckbox(2, checkboxValues, onCheckboxChanged),
                      _buildCheckbox(3, checkboxValues, onCheckboxChanged),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Helper method to build checkboxes
  Widget _buildCheckbox(
    int index,
    List<bool> values,
    Function(int, bool) onChanged,
  ) {
    return Checkbox(
      value: values[index],
      onChanged: (value) {
        onChanged(index, value ?? false);
      },
      activeColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
    );
  }
}
