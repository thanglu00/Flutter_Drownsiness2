class DataTrackingDay{
  final String trackingID;
  final String trackingTime;
  final String trackingDay;
  final String trackingMonth;
  final String trackingYear;
  final String imageUrl;
  final bool isDeleted;

  String get getDataTrackingMonth => trackingMonth;
  String get gettrackingID => trackingID;
  String get gettrackingDay => trackingDay;
  String get gettrackingTime => trackingTime;
  String get gettrackingYear => trackingYear;
  String get getimageUrl => imageUrl;
  bool get getisDeleted => isDeleted;

  DataTrackingDay(this.trackingID, this.trackingTime, this.trackingDay, this.trackingMonth, this.trackingYear, this.imageUrl, this.isDeleted);

  @override
  String toString() {
    return '{"trackingID": "$trackingID", '
        '"trackingTime": "$trackingTime", '
        '"trackingDay": "$trackingDay", '
        '"trackingMonth": "$trackingMonth", '
        '"trackingYear": "$trackingYear", '
        '"imageUrl": "$imageUrl", '
        '"isDeleted": "$isDeleted"}';
  }
}