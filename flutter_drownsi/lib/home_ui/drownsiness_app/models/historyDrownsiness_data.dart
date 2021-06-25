class DrownsinessData{
  String imagePath;
  DateTime? dateTime;
  String userName;

  DrownsinessData({
      this.imagePath = '',
      this.dateTime ,
      this.userName=''});
  static List<DrownsinessData> trackingList = <DrownsinessData>[
    DrownsinessData(
        imagePath : 'assets/images/as.png',
        dateTime : DateTime.now(),
        userName : "Nguyen Cong Thang")
  ];
}