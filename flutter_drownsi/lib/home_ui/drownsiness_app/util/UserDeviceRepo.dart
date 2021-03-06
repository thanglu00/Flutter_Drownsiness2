import 'dart:convert';

import 'package:flutter_drownsi/home_ui/drownsiness_app/models/FirmwareData.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/UserDevice.dart';
import 'package:http/http.dart' as http;

class UserDeviceRepo {

  Future<List<UserDevice>?> getHistoryByUserId(String userID, String token) async {
    final String baseUrl = "https://dhdev-drowsiness123.herokuapp.com/api/v1/user-devices/$userID/user/history";
    final result = await http.get(Uri.parse(baseUrl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (result.statusCode != 200) {
      return null;
    } else {
      var json_data = jsonDecode(utf8.decode(result.bodyBytes));
      Iterable list = json_data['results'];
      List<UserDevice> listDto = list.map((model) => UserDevice.fromObject2(model)).toList();
      return listDto;
    }
  }

  Future<UserDevice?> getCurrentConnect(String userID, String token) async {
    final String baseUrl = "https://dhdev-drowsiness123.herokuapp.com/api/v1/user-devices/$userID/userdevice";
    final result = await http.get(Uri.parse(baseUrl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (result.statusCode != 200) {
      return null;
    } else {
      var json_data = jsonDecode(utf8.decode(result.bodyBytes));
      UserDevice dto = UserDevice.fromObject(json_data['result']);
      return dto;
    }
  }

  Future<Firmware?> getLastestFirmware(String token) async {
    final String baseUrl = "https://dhdev-drowsiness123.herokuapp.com/api/v1/firmwares/newest";
    final result = await http.get(Uri.parse(baseUrl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (result.statusCode != 200) {
      return null;
    } else {
      var json_data = jsonDecode(utf8.decode(result.bodyBytes));
      Firmware dto = Firmware.fromJson(json_data['result']);
      return dto;
    }
  }

  Future<int> getLastestConnected(String token, String userId) async {
    final String baseUrl = "https://dhdev-drowsiness123.herokuapp.com/api/v1/user-devices/$userId/lastest";
    final result = await http.get(Uri.parse(baseUrl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (result.statusCode != 200) {
      return 0;
    } else {
      var json_data = jsonDecode(utf8.decode(result.bodyBytes));
      return json_data['result'];
    }
  }

  Future<bool> setConnectionUserInDevice(String token, String userId, String deviceId) async {
    final String baseUrl = "https://dhdev-drowsiness123.herokuapp.com/api/v1/user-devices/user/$userId/device/$deviceId/connect";
    final body = {
      'connected': false,
    };
    final jsonString = json.encode(body);
    final result = await http.put(Uri.parse(baseUrl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: jsonString);
    if (result.statusCode != 200) {
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}