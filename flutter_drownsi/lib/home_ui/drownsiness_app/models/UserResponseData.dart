class UserResponse{
  final String userId;
  final String username;
  final String fullName;
  final String password;
  final String phoneNumber;
  final String email;
  final String avatar;
  final int createdAt;
  final int updatedAt;
  final String token;
  final String type;
  final bool active;

  UserResponse(
      this.userId,
      this.username,
      this.fullName,
      this.password,
      this.phoneNumber,
      this.email,
      this.avatar,
      this.createdAt,
      this.updatedAt,
      this.token,
      this.type,
      this.active);

  static UserResponse fromJson(dynamic json){
    return UserResponse(
        json['userId'],
        json['username'],
        json['fullName'],
        json['password'],
        json['phoneNumber'],
        json['email'],
        json['avatar'],
        json['createdAt'],
        json['updatedAt'],
        json['token'],
        json['type'],
        json['active']);
  }
}