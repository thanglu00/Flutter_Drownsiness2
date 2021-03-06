import 'package:flutter_drownsi/home_ui/drownsiness_app/models/FirmwareData.dart';

class UserDevice {
  late String deviceName;
  late int createdAt;
  late int updatedAt;

  late int connectedAt;
  late int disconnectedAt;
  late bool connected;
  late String deviceId;

  String serialId = 'null';
  bool active = false;

  late Firmware firmware;

  UserDevice(this.deviceId, this.deviceName, this.createdAt, this.updatedAt, this.firmware, this.serialId, this.active);
  UserDevice.history(this.deviceId, this.deviceName, this.createdAt, this.connectedAt, this.disconnectedAt, this.connected);

  static UserDevice fromJson(Map<dynamic, dynamic> json) {
    return UserDevice(
      json["deviceId"],
      json["deviceName"],
      json["createdAt"],
      json["updatedAt"],
      json["firmware"],
      json["serialId"],
      json["active"],
    );
  }

  UserDevice.fromObject(dynamic o) {
    this.deviceId = o["deviceId"];
    this.deviceName = o["deviceName"];
    this.createdAt = o["createdAt"];
    this.updatedAt = o["updatedAt"];
    this.firmware = Firmware.fromJson(o["firmware"]);
    this.serialId = o['serialId'];
    this.active = o['active'];
  }

  static UserDevice fromJson2(Map<dynamic, dynamic> json) {
    return UserDevice.history(
      json["deviceId"],
      json["deviceName"],
      json["createdAt"],
      json["connectedAt"],
      json["disconnectedAt"],
      json["connected"],
    );
  }

  UserDevice.fromObject2(dynamic o) {
    this.deviceId = o["deviceId"];
    this.deviceName = o["deviceName"];
    this.createdAt = o["createdAt"];
    this.connectedAt = o["connectedAt"];
    this.disconnectedAt = o["disconnectedAt"];
    this.connected = o["connected"];
  }

}