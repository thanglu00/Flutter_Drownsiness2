import 'package:intl/intl.dart';

class DrownsinessDataTracking{
    final String trackingID;
    final String trackingTime;
    final String trackingDay;
    final String imageUrl;
    final bool isDeleted;

    DrownsinessDataTracking(this.trackingID, this.trackingTime,this.trackingDay, this.imageUrl,
        this.isDeleted);

    String get getTrackingID => trackingID;
    String get getTrackingTime => trackingTime;
    String get getTrackingDay => trackingDay;
    String get getImageUrl => imageUrl;
    bool get getTrackIsDeleted => isDeleted;


    static DrownsinessDataTracking fromJson(Map<String, dynamic> json) {
      // var list = json["results"] as List;
      // print(list.runtimeType);
      return DrownsinessDataTracking(
        json["dataTrackingId"],
        readTimestamp(json["trackingAt"]),
        readDaystamp(json["trackingAt"]),
        json["imageUrl"],
        json["deleted"],
      );
    }
}

  String readTimestamp(int timestamp) {
  var now = new DateTime.now();
  var format = new DateFormat('HH:mm a');
  var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
  var diff = date.difference(now);
  var time = '';

  if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
    time = format.format(date);
  } else {
    if (diff.inDays == 1) {
      time = diff.inDays.toString() + 'DAY AGO';
    } else {
      time = diff.inDays.toString() + 'DAYS AGO';
    }
  }

  return time;
}
String readDaystamp(int timestamp) {
  var now = new DateTime.now();
  var format = new DateFormat('yyyy-MM-dd');
  var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
  var diff = date.difference(now);
  var time = '';

  if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
    time = format.format(date);
  } else {
    if (diff.inDays == 1) {
      time = diff.inDays.toString() + 'DAY AGO';
    } else {
      time = diff.inDays.toString() + 'DAYS AGO';
    }
  }
  var date2 = format.format(date);
  return format.format(date);
}