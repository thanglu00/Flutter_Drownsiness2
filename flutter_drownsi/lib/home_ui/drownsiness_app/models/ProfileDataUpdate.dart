class ProfileDataUpdate {
  final bool isActive;
  final String avatar;
  final String email;
  final String fullname;
  final String password;
  final String username;

  ProfileDataUpdate(this.isActive, this.avatar, this.email, this.fullname, this.password, this.username);

  String get getAvatar => avatar;
  String get getEmail => email;
  String get getFullname => fullname;
  String get getPassword => password;
  String get getUsername => username;
  Map<String, dynamic> toJson() {
    return {
      "active": isActive,
      "avatar": avatar,
      "email": email,
      "fullName": fullname,
      "password": password,
      "username": username
    };
  }

}