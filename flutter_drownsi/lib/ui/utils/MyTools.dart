import 'package:intl/intl.dart';

class MyTools {
  static String readTimestamp(int timestamp) {
    if (timestamp == null) {
      return "no data";
    }

    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var formattedDate = DateFormat('dd/MM/yyyy, hh:mm:ss a').format(date); // 12/31, 11:59 pm
    return formattedDate.toString();
  }

  static String readDate(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var formattedDate = DateFormat('yyyy-MM-dd').format(date); // 12/31, 11:59 pm
    return formattedDate.toString();
  }
}