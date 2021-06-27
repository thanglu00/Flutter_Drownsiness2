import 'dart:convert';

import 'package:flutter_drownsi/home_ui/drownsiness_app/models/DrownsinessData.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/historyDrownsiness_data.dart';
import 'package:http/http.dart' as http;

class DataTrackingRepo{

  Future<List<DrownsinessDataTracking>> getDataTracking(String userID, String token) async {
    final String baseUrl = "https://dhdev-drowsiness123.herokuapp.com/api/v1/data-trackings";
    final result = await http.get(Uri.parse(baseUrl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if(result.statusCode != 200){
      throw new Exception('Error getting tracking list');
    }else{
      // final json =jsonDecode(result.body) as List;
      Map<String, dynamic> map = jsonDecode(result.body);
      List<dynamic> json = map["results"];
      print(result.body);
      List<DrownsinessDataTracking>data = [];
      for( var u in json){
          DrownsinessDataTracking dataTracking =DrownsinessDataTracking.fromJson(u);
          data.add(dataTracking);
      }
      print(data.length);
      print(data[0].getImageUrl);
      return data;
    }
  }
  Future<DrownsinessDataTracking> getDataTrackingById(String trackingID, String token) async {
    final String baseUrl = "https://dhdev-drowsiness123.herokuapp.com/api/v1/data-trackings/$trackingID";
    final result = await http.get(Uri.parse(baseUrl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if(result.statusCode != 200){
      throw new Exception('Error getting tracking list');
    }else{
      // final json =jsonDecode(result.body) as List;
      Map<String, dynamic> map = jsonDecode(result.body);
      Map<String, dynamic> json = map["result"];
      DrownsinessDataTracking data = DrownsinessDataTracking.fromJson(json);
      return data;
    }
  }

}