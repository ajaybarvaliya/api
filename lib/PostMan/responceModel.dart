// To parse this JSON data, do
//
//     final postsDetails = postsDetailsFromJson(jsonString);

import 'dart:convert';

PostsDetails postsDetailsFromJson(String str) =>
    PostsDetails.fromJson(json.decode(str));

String postsDetailsToJson(PostsDetails data) => json.encode(data.toJson());

class PostsDetails {
  String status;
  String message;
  Data data;

  PostsDetails({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PostsDetails.fromJson(Map<String, dynamic> json) => PostsDetails(
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
