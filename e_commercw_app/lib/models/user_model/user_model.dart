import 'dart:convert';

UserModel singleUserModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String singleUserModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel(
    {
    required this.userId,
    required this.userName,
    required this.userEmail,
    this.userImage,
  });

  String userId;
  String userName;
  String? userImage;
  String userEmail;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["userId"],
        userName: json["userName"],
        userImage: json["userImage"],
        userEmail: json["userEmail"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userName": userName,
        "userImage": userImage,
        "userEmail": userEmail,
      };
}
