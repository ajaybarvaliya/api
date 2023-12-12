// To parse this JSON data, do
//
//     final loginPost = loginPostFromJson(jsonString);

import 'dart:convert';

LoginPost loginPostFromJson(String str) => LoginPost.fromJson(json.decode(str));

String loginPostToJson(LoginPost data) => json.encode(data.toJson());

class LoginPost {
  String status;
  String message;
  Data data;

  LoginPost({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LoginPost.fromJson(Map<String, dynamic> json) => LoginPost(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  int userId;
  String name;

  Data({
    required this.userId,
    required this.name,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
      };
}
