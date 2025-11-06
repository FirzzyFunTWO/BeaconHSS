import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  final String status;
  final String coords;
  const StatusCard({super.key, required this.status, required this.coords});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Status: $status", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text("Koordinat: $coords", style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}