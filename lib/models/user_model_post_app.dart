// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModelPostApp {
  static const String tableName = 'post_app_users';

  String? userName;
  String? userImage;
  String? id;
  String? email; // ✅ NEW FIELD

  UserModelPostApp({
    this.userName,
    this.userImage,
    this.id,
    this.email, // added
  });

  UserModelPostApp copyWith({
    String? userName,
    String? userImage,
    String? id,
    String? email, // added
  }) {
    return UserModelPostApp(
      userName: userName ?? this.userName,
      userImage: userImage ?? this.userImage,
      id: id ?? this.id,
      email: email ?? this.email, // added
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'userImage': userImage,
      'id': id,
      'email': email, // added
    };
  }

  factory UserModelPostApp.fromMap(Map<String, dynamic> map) {
    return UserModelPostApp(
      userName: map['userName'] != null ? map['userName'] as String : null,
      userImage: map['userImage'] != null ? map['userImage'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      email: map['email'] != null ? map['email'] as String : null, // added
    );
  }
}

// // ignore_for_file: public_member_api_docs, sort_constructors_first
// class UserModelPostApp {
//   static const String tableName = 'post_app_users';
//   final String userName;
//   final String userImage;
//   final String id;
//   UserModelPostApp({
//     required this.userName,
//     required this.userImage,
//     required this.id,
//   });

//   UserModelPostApp copyWith({String? userName, String? userImage, String? id}) {
//     return UserModelPostApp(
//       userName: userName ?? this.userName,
//       userImage: userImage ?? this.userImage,
//       id: id ?? this.id,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'userName': userName,
//       'userImage': userImage,
//       'id': id,
//     };
//   }

//   factory UserModelPostApp.fromMap(Map<String, dynamic> map) {
//     return UserModelPostApp(
//       userName: map['userName'] as String,
//       userImage: map['userImage'] as String,
//       id: map['id'] as String,
//     );
//   }
// }
