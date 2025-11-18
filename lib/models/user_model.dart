// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:application_new/models/category_model.dart';

class UserModel {
  static const String tableName = 'application_new_users';
  final String email;
  final String name;
  final String id;
  List<CategoryModel> cateories;
  UserModel({
    required this.email,
    required this.name,
    required this.id,
    required this.cateories,
  });

  UserModel copyWith({
    String? email,
    String? name,
    String? id,
    List<CategoryModel>? cateories,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      id: id ?? this.id,
      cateories: cateories ?? this.cateories,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'id': id,
      'cateories': cateories.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    final categoriesList = map['cateories'];
    return UserModel(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      id: map['id'] ?? '',
      cateories:
          categoriesList is List
              ? categoriesList
                  .map((x) => CategoryModel.fromMap(x as Map<String, dynamic>))
                  .toList()
              : [],
    );
  }
}
