import 'package:flutter/material.dart';
import 'lele_farm_screen.dart';

void main() {
  runApp(const WeatherData());
}

class WeatherData extends StatelessWidget {
  const WeatherData({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: [
            // Back Button and Title
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    onPressed: () {
                      // Navigate to calendar screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LeleFarmScreen(),
                        ),
                      );
                    },
                  ),
                  Spacer(),
                  Text(
                    "Weather Status",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                ],
              ),
            ),

            // Weather Information
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      "Today",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Today is Rain",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "32°C",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              WeatherDayBox(
                                day: "21st",
                                temp: "32°C",
                                icon: Icons.cloud,
                              ),
                              WeatherDayBox(
                                day: "22nd",
                                temp: "32°C",
                                icon: Icons.wb_sunny,
                              ),
                              WeatherDayBox(
                                day: "23rd",
                                temp: "32°C",
                                icon: Icons.bolt,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),
                    InfoBox(
                      title: "Location",
                      subtitle: "Kuala Lumpur",
                      icon: Icons.location_pin,
                    ),
                    InfoBox(
                      title: "Last Update",
                      subtitle: "Just Now",
                      icon: Icons.update,
                    ),
                    InfoBox(
                      title: "Summary",
                      subtitle:
                          "Expect low temp throughout the day. Preferred to water crops less",
                      icon: Icons.note,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherDayBox extends StatelessWidget {
  final String day;
  final String temp;
  final IconData icon;

  WeatherDayBox({required this.day, required this.temp, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(day, style: TextStyle(color: Colors.white)),
        Icon(icon, color: Colors.white, size: 30),
        Text(temp, style: TextStyle(color: Colors.white)),
      ],
    );
  }
}

class InfoBox extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  InfoBox({required this.title, required this.subtitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 40),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
