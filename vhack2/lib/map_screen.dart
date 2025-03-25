import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  MapScreen({super.key});

  final Map<String, String> sensorData = {
    'A': 'P: 1%  K: 2%  N: 6%  Na: 9%  Fe:10%  Om: 13%',
    'B': 'P: 3%  K: 5%  N: 2%  Na: 8%  Fe:12%  Om: 20%',
    'C': 'P: 2%  K: 9%  N: 5%  Na: 9%  Fe:22%  Om: 26%',
    'D': 'P: 7%  K: 9%  N: 1%  Na: 9%  Fe:32%  Om: 21%',
    'E': 'P: 5%  K: 5%  N: 2%  Na: 8%  Fe:12%  Om: 20%',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Kuala Lumpur',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.orange,
              child: Icon(Icons.person, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Image.asset(
                  'assets/map.png', // Ensure you have this image in your assets folder
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: Container(color: Colors.black.withOpacity(0.2)),
                ),
                Positioned.fill(
                  child: Center(
                    child: SizedBox(
                      width: 250,
                      height: 250,
                      child: Stack(
                        children: [
                          Container(color: Colors.grey.withOpacity(0.5)),
                          Positioned(
                            top: 20,
                            left: 20,
                            child: _buildRedDot('A'),
                          ),
                          Positioned(
                            top: 20,
                            right: 20,
                            child: _buildRedDot('B'),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: _buildRedDot('C'),
                          ),
                          Positioned(
                            bottom: 20,
                            right: 20,
                            child: _buildRedDot('D'),
                          ),
                          Positioned(
                            bottom: 100,
                            left: 100,
                            child: _buildRedDot('E'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sensor Data',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 16,
                        columns: const [
                          DataColumn(label: Text('Sensor')),
                          DataColumn(label: Text('P')),
                          DataColumn(label: Text('K')),
                          DataColumn(label: Text('N')),
                          DataColumn(label: Text('Na')),
                          DataColumn(label: Text('Fe')),
                          DataColumn(label: Text('Om')),
                        ],
                        rows: [
                          _buildDataRow(
                            'A',
                            '1%',
                            '2%',
                            '6%',
                            '9%',
                            '10%',
                            '13%',
                          ),
                          _buildDataRow(
                            'B',
                            '3%',
                            '5%',
                            '2%',
                            '8%',
                            '12%',
                            '20%',
                          ),
                          _buildDataRow(
                            'C',
                            '2%',
                            '9%',
                            '5%',
                            '9%',
                            '22%',
                            '26%',
                          ),
                          _buildDataRow(
                            'D',
                            '7%',
                            '9%',
                            '1%',
                            '9%',
                            '32%',
                            '21%',
                          ),
                          _buildDataRow(
                            'E',
                            '5%',
                            '5%',
                            '2%',
                            '8%',
                            '12%',
                            '20%',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: ''),
        ],
        backgroundColor: Colors.white,
        elevation: 5,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  Widget _buildRedDot(String sensor) {
    return MouseRegion(
      onEnter: (event) {},
      child: Tooltip(
        message: 'Sensor $sensor:\n${sensorData[sensor] ?? ''}',
        child: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
        ),
      ),
    );
  }

  DataRow _buildDataRow(
    String sensor,
    String p,
    String k,
    String n,
    String na,
    String fe,
    String om,
  ) {
    return DataRow(
      cells: [
        DataCell(Text('Sensor $sensor')),
        DataCell(Text(p)),
        DataCell(Text(k)),
        DataCell(Text(n)),
        DataCell(Text(na)),
        DataCell(Text(fe)),
        DataCell(Text(om)),
      ],
    );
  }
}
