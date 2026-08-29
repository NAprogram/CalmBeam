import 'package:flutter/material.dart';
import 'package:lamp_app/models/lamp_data.dart';
import 'package:lamp_app/widgets/sensor_card.dart';

class DemoHomeScreen extends StatefulWidget {
  const DemoHomeScreen({super.key});

  @override
  State<DemoHomeScreen> createState() => _DemoHomeScreenState();
}

class _DemoHomeScreenState extends State<DemoHomeScreen> {
  List<LampData> demoLamps = [
    LampData(
      id: 'demo1',
      lampName: 'Living Room Lamp',
      temperature: 22.5,
      humidity: 55.0,
      timestamp: DateTime.now(),
      status: 'online',
    ),
    LampData(
      id: 'demo2',
      lampName: 'Bedroom Lamp',
      temperature: 25.0,
      humidity: 45.0,
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      status: 'online',
    ),
    LampData(
      id: 'demo3',
      lampName: 'Kitchen Lamp',
      temperature: 18.0,
      humidity: 75.0,
      timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
      status: 'online',
    ),
  ];

  void _showAddLampDialog() {
    TextEditingController lampNameController = TextEditingController();
    TextEditingController tempController = TextEditingController();
    TextEditingController humidityController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Lamp (Demo)'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: lampNameController,
                  decoration: const InputDecoration(
                    labelText: 'Lamp Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: tempController,
                  decoration: const InputDecoration(
                    labelText: 'Temperature (°C)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: humidityController,
                  decoration: const InputDecoration(
                    labelText: 'Humidity (%)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (lampNameController.text.isEmpty ||
                    tempController.text.isEmpty ||
                    humidityController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all fields')),
                  );
                  return;
                }

                setState(() {
                  demoLamps.add(LampData(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    lampName: lampNameController.text,
                    temperature: double.parse(tempController.text),
                    humidity: double.parse(humidityController.text),
                    timestamp: DateTime.now(),
                    status: 'online',
                  ));
                });

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Lamp added successfully! (Demo)')),
                );
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lamp Monitor Dashboard'),
        elevation: 0,
        backgroundColor: const Color(0xFF667EEA),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF667EEA).withOpacity(0.1),
              const Color(0xFF764BA2).withOpacity(0.1)
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.info, color: Colors.blue),
                          SizedBox(width: 8),
                          Text(
                            'Demo Mode Active',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This app is running in demo mode with sample data. '
                        'No Firebase connection required.',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ...demoLamps.map((lamp) {
                return Column(
                  children: [
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.white, Colors.grey[50]!],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lamp.lampName,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: lamp.status == 'online'
                                            ? Colors.green[100]
                                            : Colors.red[100],
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        lamp.status.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: lamp.status == 'online'
                                              ? Colors.green[900]
                                              : Colors.red[900],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      demoLamps.remove(lamp);
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Lamp removed (Demo)')),
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                SensorCard(
                                  title: 'Temperature',
                                  value: lamp.temperature,
                                  unit: '°C',
                                  icon: Icons.thermostat,
                                  sensorType: SensorType.temperature,
                                ),
                                SensorCard(
                                  title: 'Humidity',
                                  value: lamp.humidity,
                                  unit: '%',
                                  icon: Icons.opacity,
                                  sensorType: SensorType.humidity,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddLampDialog,
        backgroundColor: const Color(0xFF667EEA),
        tooltip: 'Add Demo Lamp',
        child: Icon(Icons.add),
      ),
    );
  }
}
