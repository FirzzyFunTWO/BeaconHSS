import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BleService {
  final FlutterBluePlus flutterBlue = FlutterBluePlus();
  BluetoothDevice? device;

  Future<bool> connectToEsp32() async {
    try {
      await flutterBlue.startScan(timeout: const Duration(seconds: 5));
      await for (var result in flutterBlue.scanResults) {
        if (result.device.name.contains("ESP32")) {
          device = result.device;
          await device!.connect();
          await flutterBlue.stopScan();
          return true;
        }
      }
    } catch (e) {
      print("BLE Error: $e");
    }
    return false;
  }

  Future<void> sendGpsToEsp32(String coords) async {
    if (device == null) return;
    var services = await device!.discoverServices();
    for (var service in services) {
      for (var char in service.characteristics) {
        await char.write(coords.codeUnits, withoutResponse: true);
      }
    }
  }
}