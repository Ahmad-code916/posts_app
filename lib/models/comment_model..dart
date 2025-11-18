// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:application_new/models/user_model_post_app.dart';

class CommentModel {
  static const String tableName = 'comments';

  String? comment;
  String? senderId;
  UserModelPostApp? senderData;

  CommentModel({this.comment, this.senderId, this.senderData});

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      comment: map["comment"] ?? "",
      senderId: map["senderId"] ?? "",
      senderData:
          map["senderData"] != null
              ? UserModelPostApp.fromMap(map["senderData"])
              : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "comment": comment,
      "senderId": senderId,
      "senderData": senderData?.toMap(),
    };
  }

  CommentModel copyWith({
    String? comment,
    String? senderId,
    UserModelPostApp? senderData,
  }) {
    return CommentModel(
      comment: comment ?? this.comment,
      senderId: senderId ?? this.senderId,
      senderData: senderData ?? this.senderData,
    );
  }
}
