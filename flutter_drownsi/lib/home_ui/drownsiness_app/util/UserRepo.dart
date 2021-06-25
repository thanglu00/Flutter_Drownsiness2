import 'dart:convert';

import 'package:flutter_drownsi/home_ui/drownsiness_app/models/ProfileData.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/ProfileDataUpdate.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/UserPostData.dart';
import 'package:flutter_drownsi/home_ui/drownsiness_app/models/UserResponseData.dart';
import 'package:http/http.dart' as http;

class UserRepo{
  Future<ProfileData> getUser(String userID,String token) async {
    final String baseUrl = "https://dhdev-drowsiness123.herokuapp.com/api/v1/users/$userID";
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
      print(result.body);
      // List<dynamic> json = map["result"] as List;
        ProfileData dataTracking = ProfileData.fromJson(map["result"]);
      print(dataTracking);
      return dataTracking;
    }
  }
  Future<bool> updateUser(String userID,String token, ProfileDataUpdate data) async {
    final String baseUrl = "https://dhdev-drowsiness123.herokuapp.com/api/v1/users/$userID";
    final result = await http.put(
        Uri.parse(baseUrl),
        headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
          'Authorization': 'Bearer $token',
    },
      body: json.encode(data.toJson())
    );
    if(result.statusCode != 200){
      throw new Exception('Error getting tracking list');
    }else{
      return true;
    }
  }

  Future<UserResponse> getAuthoLogin(UserPost post) async{
    final baseUrl ="https://dhdev-drowsiness123.herokuapp.com/api/auth/login-mail";
    final result = await http.post(Uri.parse(baseUrl),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },body:jsonEncode(post.toJson(post)));
    print(result.body);
    print("Day la ket qua");
    var map = jsonDecode(result.body);
    ResponseMessage responseMessage = ResponseMessage.fromJson(map);
    print(responseMessage.data.fullName);

    print(responseMessage);
    return responseMessage.data;
  }
}
class ResponseMessage{
  final String status;
  final String message;
  final UserResponse data;

  ResponseMessage(this.status, this.message, this.data);
  static ResponseMessage fromJson(dynamic json){
    return ResponseMessage(
      json["status"] as String,
      json["message"] as String,
      UserResponse.fromJson(json["data"]),
    );
  }

}
