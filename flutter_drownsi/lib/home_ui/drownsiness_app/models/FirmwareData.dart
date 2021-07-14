class Firmware {
  final String firmwareId;
  final String description;
  final String modelUrl;
  final double timeDetection;
  final int createdAt;

  Firmware(this.firmwareId, this.description, this.modelUrl, this.timeDetection, this.createdAt);

  static Firmware fromJson(Map<String, dynamic> json) {
    // var list = json["results"] as List;
    // print(list.runtimeType);
    return Firmware(
      json["firmwareId"],
      json["description"],
      json["modelUrl"],
      json["timeDetection"],
      json["createdAt"],
    );
  }

}