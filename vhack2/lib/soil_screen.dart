import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SoilStatusScreen extends StatelessWidget {
  const SoilStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Soil Status'),
        backgroundColor: Colors.grey[300],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        // ✅ Fixes overflow issue
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildFertilizerStatus(),
              const SizedBox(height: 16),
              _buildFertilityStatusTable(),
              const SizedBox(height: 16),
              _buildAmountNeededTable(),
            ],
          ),
        ),
      ),
    );
  }

  /// **🌱 Fertilizer Status Box**
  Widget _buildFertilizerStatus() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          CircularPercentIndicator(
            radius: 50.0,
            lineWidth: 10.0,
            percent: 0.65, // 65% progress
            center: const Text(
              "65%",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            progressColor: Colors.red,
            backgroundColor: Colors.grey[300]!,
            circularStrokeCap: CircularStrokeCap.round,
          ),
          const SizedBox(height: 8),
          const Text(
            "Your fertilizer is healthy",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Text(
            "Pls check again in 2 days",
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  /// **📊 Soil Fertility Status Table**
  Widget _buildFertilityStatusTable() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Soil Fertility Status Table",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildProgressRow("pH (water)", 0.9),
          _buildProgressRow("Phosphorus (M3)", 0.4),
          _buildProgressRow("Potassium", 0.5),
          _buildProgressRow("Nitrogen", 0.6),
          _buildProgressRow("Sodium", 0.3),
          _buildProgressRow("Iron", 0.2),
          _buildProgressRow("Organic Matter", 0.45),
        ],
      ),
    );
  }

  /// **📌 Amount Needed Table**
  Widget _buildAmountNeededTable() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Amount Needed",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildAmountRow("pH (water)", "Great"),
          _buildAmountRow("Phosphorus (M3)", "Need another 20%"),
          _buildAmountRow("Potassium", "Need another 42%"),
          _buildAmountRow("Nitrogen", "Good"),
          _buildAmountRow("Sodium", "Great"),
          _buildAmountRow("Iron", "Over the correct amount"),
          _buildAmountRow("Organic Matter", "Need another 20%"),
        ],
      ),
    );
  }

  /// **📉 Progress Bar Row**
  Widget _buildProgressRow(String title, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          LinearProgressIndicator(
            value: value,
            backgroundColor: Colors.red,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            minHeight: 10,
          ),
        ],
      ),
    );
  }

  /// **📌 Amount Row**
  Widget _buildAmountRow(String title, String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          Text(
            status,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
