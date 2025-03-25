import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WaterData extends StatefulWidget {
  @override
  _WaterDataState createState() => _WaterDataState();
}

class _WaterDataState extends State<WaterData> {
  bool isAuto = true;
  bool isOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.brown),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Water Status", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Kuala Lumpur",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildWaterSystemToggle(),
            SizedBox(height: 10),
            isAuto ? _buildWeeklyUsage() : _buildExpectedUsage(),
            SizedBox(height: 10),
            _buildDailyUsageChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildWaterSystemToggle() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text("Water System", style: TextStyle(fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ToggleButtons(
                isSelected: [!isAuto, isAuto],
                children: [Text("Manual"), Text("Auto")],
                onPressed: (index) {
                  setState(() {
                    isAuto = index == 1;
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: isOn,
                onChanged: (value) {
                  setState(() {
                    isOn = value ?? false;
                  });
                },
              ),
              Text("On"),
              Checkbox(
                value: !isOn,
                onChanged: (value) {
                  setState(() {
                    isOn = !(value ?? true);
                  });
                },
              ),
              Text("Off"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyUsage() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildCircularIndicator("Used", 0.65, Colors.red),
          _buildCircularIndicator("Wasted", 0.06, Colors.grey),
        ],
      ),
    );
  }

  Widget _buildExpectedUsage() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Expected Water Usage",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                barGroups: _getExpectedBarGroups(),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(show: true),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularIndicator(String label, double value, Color color) {
    return Column(
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: CircularProgressIndicator(
            value: value,
            color: color,
            backgroundColor: Colors.grey[300],
          ),
        ),
        SizedBox(height: 5),
        Text("${(value * 100).toInt()}% $label"),
      ],
    );
  }

  Widget _buildDailyUsageChart() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Daily Water Usage and Waste",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                barGroups: _getBarGroups(),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(show: true),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> _getBarGroups() {
    return List.generate(
      7,
      (index) => BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            fromY: 0,
            toY: index % 2 == 0 ? 1.0 : -0.5,
            color: index % 2 == 0 ? Colors.green : Colors.red,
            width: 10,
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> _getExpectedBarGroups() {
    return List.generate(
      7,
      (index) => BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            fromY: 0,
            toY: index % 2 == 0 ? 1.2 : 0.8,
            color: Colors.red,
            width: 10,
          ),
          BarChartRodData(
            fromY: 0,
            toY: index % 2 == 0 ? 1.0 : 0.6,
            color: Colors.green,
            width: 10,
          ),
        ],
      ),
    );
  }
}
