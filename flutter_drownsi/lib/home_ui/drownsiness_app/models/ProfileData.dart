import 'package:intl/intl.dart';

class ProfileData{
  final String userId;
  final String username;
  final String fullName;
  final String password;
  final String phoneNumber;
  final String email;
  final String avatar;
  final String? createdAt;
  final String? updatedAt;
  final bool isActive;

  ProfileData(
      this.userId,
      this.username,
      this.fullName,
      this.password,
      this.phoneNumber,
      this.email,
      this.avatar,
      this.createdAt,
      this.updatedAt,
      this.isActive);

  String get getuserId => userId;
  String get getusername => username;
  String get getfullName => fullName;
  String get getpassword => password;
  String get getphoneNumber => phoneNumber;
  String get getemail => email;
  String get getavatar => avatar;
  String? get getcreatedAt => createdAt;
  String? get getupdatedAt => updatedAt;
  bool get getisActive => isActive;

  static ProfileData fromJson(Map<String, dynamic> json) {
    return ProfileData(
      json["userId"],
      json["username"],
      json["fullName"],
      json["password"],
      json["phoneNumber"],
      json["email"],
      json["avatar"],
      readDaystamp(json["createdAt"]),
      readDaystamp(json["updatedAt"]),
      json["active"],
    );
  }



}
String? readDaystamp(int? timestamp) {
    if (timestamp != null) {
      var now = new DateTime.now();
      var format = new DateFormat('yyyy-MM-dd');
      var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
      var diff = date.difference(now);
      var time = '';

      if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 ||
          diff.inMinutes > 0 && diff.inHours == 0 ||
          diff.inHours > 0 && diff.inDays == 0) {
        time = format.format(date);
      } else {
        if (diff.inDays == 1) {
          time = diff.inDays.toString() + 'DAY AGO';
        } else {
          time = diff.inDays.toString() + 'DAYS AGO';
        }
      }

      return format.format(date);
    }
}