class Device {
  final String deviceId;
  final String deviceName;
  final int createdAt;
  final int updatedAt;

  Device(this.deviceId, this.deviceName, this.createdAt, this.updatedAt);

  static Device fromJson(Map<String, dynamic> json) {
    // var list = json["results"] as List;
    // print(list.runtimeType);
    return Device(
      json["deviceId"],
      json["deviceName"],
      json["createdAt"],
      json["updatedAt"],
    );
  }

}