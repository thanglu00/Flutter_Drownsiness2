class DatatrackingDTO {
  late String dataTrackingId;
  late int trackingAt;
  late String imageUrl;
  late String deviceId;
  late String deviceName;
  late bool deleted;

  DatatrackingDTO.n();
  DatatrackingDTO(this.dataTrackingId, this.trackingAt, this.imageUrl, this.deviceId, this.deviceName, this.deleted);

  static DatatrackingDTO fromJson(Map<dynamic, dynamic> json) {
    return DatatrackingDTO(
      json["dataTrackingId"],
      json["trackingAt"],
      json["imageUrl"],
      json["deviceId"],
      json["deviceName"],
      json["deleted"],
    );
  }

  DatatrackingDTO.fromObject(dynamic o) {
    this.dataTrackingId = o["dataTrackingId"];
    this.trackingAt = o["trackingAt"];
    this.imageUrl = o["imageUrl"];
    this.deviceId = o["deviceId"];
    this.deviceName = o["deviceName"];
    this.deleted = o["deleted"];
  }

}