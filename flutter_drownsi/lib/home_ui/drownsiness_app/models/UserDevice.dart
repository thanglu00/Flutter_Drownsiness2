class UserDevice {
  late String deviceName;
  late int createdAt;
  late int updatedAt;

  UserDevice(this.deviceName, this.createdAt, this.updatedAt);

  static UserDevice fromJson(Map<dynamic, dynamic> json) {
    return UserDevice(
      json["deviceName"],
      json["createdAt"],
      json["updatedAt"],
    );
  }

  UserDevice.fromObject(dynamic o) {
    this.deviceName = o["deviceName"];
    this.createdAt = o["createdAt"];
    this.updatedAt = o["updatedAt"];
  }

}