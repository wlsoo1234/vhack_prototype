import 'package:flutter/material.dart';
import 'farm_dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF9DFFC7,
      ), // Vibrant green background color as shown in the image
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Circular robot image
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.grey[400]!, width: 1.0),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        'https://placehold.co/120x120?text=Robot+Watering+Plant',
                        fit: BoxFit.cover,
                        // In a real app, replace with the yellow robot with blue eyes watering a plant
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.smart_toy,
                            size: 60,
                            color: Colors.amber,
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Username label
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 4.0, bottom: 4.0),
                      child: Text(
                        'Username',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ),
                  ),

                  // Username input field with rounded edges
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Password label
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 4.0, bottom: 4.0),
                      child: Text(
                        'Password',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ),
                  ),

                  // Password input field with rounded edges
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Inside your LoginScreen class, update the Login button:

                  // Login button
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to the farm dashboard screen after login
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FarmDashboardScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Back text button
                  TextButton(
                    onPressed: () {
                      // Navigate back to welcome screen
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black87,
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text('Back', style: TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
