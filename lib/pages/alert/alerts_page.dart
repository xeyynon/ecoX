import 'package:flutter/material.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // For now, static demo list. Later we can feed real alerts.
    final alerts = [
      {"gas": "CO₂", "value": "1200 ppm", "status": "High"},
      {"gas": "NO₂", "value": "90 ppm", "status": "Moderate"},
      {"gas": "PM2.5", "value": "250 µg/m³", "status": "Dangerous"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Alerts")),
      body: ListView.builder(
        itemCount: alerts.length,
        itemBuilder: (context, index) {
          final alert = alerts[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: Icon(Icons.warning, color: Colors.red.shade700, size: 32),
              title: Text("${alert['gas']} Alert"),
              subtitle: Text("Level: ${alert['value']}"),
              trailing: Text(
                alert['status']!,
                style: TextStyle(
                  color: alert['status'] == "High" || alert['status'] == "Dangerous"
                      ? Colors.red
                      : Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
