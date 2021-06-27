import 'package:flutter_drownsi/home_ui/drownsiness_app/models/DrownsinessData.dart';

class DeviceTracking{
  final String deviceId;
  final String deviceName;
  final int createAt;
  final int updateAt;

  DeviceTracking(this.deviceId, this.deviceName, this.createAt, this.updateAt);

  static DeviceTracking fromJson(Map<String, dynamic> json) {
    // var list = json["results"] as List;
    // print(list.runtimeType);
    return DeviceTracking(
      json["deviceId"],
      json["deviceName"],
      json["createAt"],
      json["updateAt"],
    );
  }
}
class DataTrackingOnEachDevice{
  final DeviceTracking device;
  final List<DrownsinessDataTracking> dataTracking;

  List<DrownsinessDataTracking> get getDataTracking => dataTracking;

  DataTrackingOnEachDevice(this.device, this.dataTracking);


  static DataTrackingOnEachDevice fromJson(Map<String, dynamic> json){
    var list = json['dataTrackings'] as List;
    print(list.runtimeType);
    List<DrownsinessDataTracking> deviceList = list.map((i) => DrownsinessDataTracking.fromJson(i)).toList();
    return DataTrackingOnEachDevice(
        DeviceTracking.fromJson(json['deviceDTO']),
        deviceList);
  }
}
