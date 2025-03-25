import 'package:flutter/material.dart';
import 'welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const WelcomeScreen(), // Use FarmDashboardScreen for direct testing
      // Alternatively, keep WelcomeScreen and navigate to FarmDashboardScreen after login
      // home: const WelcomeScreen(),
    );
  }
}
