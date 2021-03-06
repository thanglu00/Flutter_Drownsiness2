import 'dart:convert';

import 'package:flutter_drownsi/home_ui/drownsiness_app/models/DataTrackingOnDevice.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/DeviceData.dart';
import 'package:http/http.dart' as http;

class DeviceRepo {


  Future<List<DataTrackingOnEachDevice>> getDataTrackingWithDevice(String userID, String token) async {
    final String baseUrl = "https://dhdev-drowsiness123.herokuapp.com/api/v1/data-trackings/users/$userID";
    final result = await http.get(Uri.parse(baseUrl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if(result.statusCode != 200){
      throw new Exception('Error getting tracking list');
    }else{
      // final json =jsonDecode(result.body) as List;
      var map = jsonDecode(result.body) as List;
      // List<dynamic> json = map as List;
      print(map);
      List<DataTrackingOnEachDevice>data = [];
      for( var u in map){
        DataTrackingOnEachDevice dataTracking =DataTrackingOnEachDevice.fromJson(u);
        data.add(dataTracking);
      }
      print(data.length);
      print(data[0]);
      return data;
    }
  }

  Future<Device> getDevice(String deviceID, String token) async {
    final String baseUrl = "https://dhdev-drowsiness123.herokuapp.com/api/v1/devices/$deviceID";
    final result = await http.get(Uri.parse(baseUrl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if(result.statusCode != 200){
      throw new Exception('Error getting tracking list');
    }else{

      var json = jsonDecode(utf8.decode(result.bodyBytes));
      Device data = Device.fromJson(json['result']);
      return data;
    }
  }

  Future<bool> updateDeviceName(String deviceID, String token, String newName) async {
    final String baseUrl = "https://dhdev-drowsiness123.herokuapp.com/api/v1/devices/$deviceID";
    final body = {
      'deviceName': "$newName",
    };
    final jsonString = json.encode(body);
    final result = await http.put(Uri.parse(baseUrl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: jsonString);
    if(result.statusCode != 200){
      throw new Exception('Error!');
    }else{
      print(result.toString());
      return true;
    }
  }
}