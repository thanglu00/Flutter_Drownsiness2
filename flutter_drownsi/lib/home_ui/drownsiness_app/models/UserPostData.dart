class UserPost {
  final String? imgUrl;
  final String? gmail;
  final String? name;
  final String? phoneNumber;
  final String? uuid;

  UserPost({this.imgUrl, this.gmail, this.name, this.phoneNumber, this.uuid});

  static UserPost fromJson(Map<String,dynamic> json){
    return UserPost(
      imgUrl: json['avatar'],
      gmail : json['email'],
      name: json['fullName'],
      phoneNumber: json['phoneNumber'],
      uuid:json['uuid'],
    );
  }
  Map<String,dynamic> toJson(UserPost po) => <String,dynamic>{
    "avatar":imgUrl,
    "email":gmail,
    "fullName":name,
    "phoneNumber":phoneNumber,
    "uuid":uuid,
  };
// Map toMap(){
//   var map = new Map<String,dynamic>();
//   map["phone"] = phoneNumber;
//   map["name"] = name;
//   print(map);
//   return map;
//
// }

}