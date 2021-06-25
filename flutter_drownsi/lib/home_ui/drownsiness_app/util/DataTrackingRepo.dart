import 'dart:convert';

import 'package:flutter_drownsi/home_ui/drownsiness_app/models/DrownsinessData.dart';
import 'package:http/http.dart' as http;

class DataTrackingRepo{

  Future<List<DrownsinessDataTracking>> getDataTracking(String userID, String deviceID) async {
    final String baseUrl = "https://dhdev-drowsiness123.herokuapp.com/api/v1/data-trackings/users/$userID/devices/$deviceID";
    final result = await http.get(Uri.parse(baseUrl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
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


}