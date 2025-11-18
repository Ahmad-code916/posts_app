// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:application_new/models/user_model_post_app.dart';

class PostModel {
  static const tableName = "post_app_posts";

  String? id;
  String? postImage;
  UserModelPostApp? user;
  List<String>? likedBy;

  PostModel({this.id, this.postImage, this.user, this.likedBy});

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map["id"] ?? "",
      postImage: map["postImage"] ?? "",
      user: map["user"] != null ? UserModelPostApp.fromMap(map["user"]) : null,
      likedBy: map["likedBy"] != null ? List<String>.from(map["likedBy"]) : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "postImage": postImage,
      "user": user?.toMap(),
      "likedBy": likedBy,
    };
  }

  PostModel copyWith({
    String? id,
    String? postImage,
    UserModelPostApp? user,
    List<String>? likedBy,
  }) {
    return PostModel(
      id: id ?? this.id,
      postImage: postImage ?? this.postImage,
      user: user ?? this.user,
      likedBy: likedBy ?? this.likedBy,
    );
  }
}
