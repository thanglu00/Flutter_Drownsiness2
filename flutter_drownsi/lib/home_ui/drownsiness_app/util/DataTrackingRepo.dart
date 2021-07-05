import 'dart:convert';

import 'package:flutter_drownsi/home_ui/drownsiness_app/models/DataTrackingDTO.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/DrownsinessData.dart';
import 'package:http/http.dart' as http;

class DataTrackingRepo{

  Future<bool> deleteById(String dataTrackingId, String token) async {
    final String baseUrl = "https://dhdev-drowsiness123.herokuapp.com/api/v1/data-trackings/$dataTrackingId";
    final body = {
      'deleted': "true",
    };
    final jsonString = json.encode(body);
    final result = await http.put(Uri.parse(baseUrl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: jsonString);
    print(result.body);
    if (result.statusCode != 200) {
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  Future<List<DatatrackingDTO>?> getByUserId(String userID, String token) async {
    final String baseUrl = "https://dhdev-drowsiness123.herokuapp.com/api/v1/data-trackings/user/$userID";
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
      List<DatatrackingDTO> listDto = list.map((model) => DatatrackingDTO.fromObject(model)).toList();
      return listDto;
    }
  }

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
      Map<String, dynamic> map = jsonDecode(utf8.decode(result.bodyBytes));
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
      Map<String, dynamic> map = jsonDecode(utf8.decode(result.bodyBytes));
      Map<String, dynamic> json = map["result"];
      DrownsinessDataTracking data = DrownsinessDataTracking.fromJson(json);
      return data;
    }
  }

}