import 'package:flutter_drownsi/home_ui/drownsiness_app/models/FirmwareData.dart';

class Device {
  final String deviceId;
  final String deviceName;
  final int createdAt;
  final int updatedAt;
  final Firmware firmware;

  Device(this.deviceId, this.deviceName, this.createdAt, this.updatedAt, this.firmware);

  static Device fromJson(Map<String, dynamic> json) {
    // var list = json["results"] as List;
    // print(list.runtimeType);
    return Device(
      json["deviceId"],
      json["deviceName"],
      json["createdAt"],
      json["updatedAt"],
      Firmware.fromJson(json["firmware"])
    );
  }

}