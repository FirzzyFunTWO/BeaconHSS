import 'package:flutter/material.dart';
import '../services/ble_service.dart';
import '../services/location_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/status_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _status = "Disconnected";
  String _coords = "Unknown";

  final ble = BleService();
  final gps = LocationService();

  @override
  void initState() {
    super.initState();
    gps.initLocation();
  }

  void _getGpsAndSend() async {
    final position = await gps.getCurrentLocation();
    setState(() => _coords = "${position.latitude}, ${position.longitude}");
    await ble.sendGpsToEsp32(_coords);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("HSS BLE Controller")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StatusCard(status: _status, coords: _coords),
            CustomButton(
              text: "Kirim GPS ke ESP32",
              onPressed: _getGpsAndSend,
            ),
            CustomButton(
              text: "Koneksi BLE",
              onPressed: () async {
                final connected = await ble.connectToEsp32();
                setState(() => _status = connected ? "Connected" : "Failed");
              },
            ),
          ],
        ),
      ),
    );
  }
}