import 'package:flutter/material.dart';

class CropEntryScreen extends StatefulWidget {
  final Function(String) onCropAdded;

  const CropEntryScreen({super.key, required this.onCropAdded});

  @override
  State<CropEntryScreen> createState() => _CropEntryScreenState();
}

class _CropEntryScreenState extends State<CropEntryScreen> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _placeNameController = TextEditingController();
  List<bool> _cropTypes = [
    false,
    false,
    false,
    false,
  ]; // Rice, Tomato, Corn, SoyBean

  @override
  void dispose() {
    _locationController.dispose();
    _addressController.dispose();
    _ownerNameController.dispose();
    _placeNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Crop'),
        backgroundColor: Colors.grey[300],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField('Location of crops', _locationController),
              const SizedBox(height: 16),
              _buildTextField('Crops Address', _addressController),
              const SizedBox(height: 16),
              _buildTextField('Owner names', _ownerNameController),
              const SizedBox(height: 16),
              _buildTextField('Place name', _placeNameController),
              const SizedBox(height: 16),
              const Text(
                'What type of Crops',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildCheckbox('Rice', 0),
              _buildCheckbox('Tomato', 1),
              _buildCheckbox('Corn', 2),
              _buildCheckbox('SoyBean', 3),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Add the new crop entry
                    String cropName = _locationController.text;
                    widget.onCropAdded(cropName);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Update'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build text fields
  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  // Helper method to build checkboxes
  Widget _buildCheckbox(String label, int index) {
    return Row(
      children: [
        Checkbox(
          value: _cropTypes[index],
          onChanged: (value) {
            setState(() {
              _cropTypes[index] = value ?? false;
            });
          },
          activeColor: Colors.black,
        ),
        Text(label),
      ],
    );
  }
}
