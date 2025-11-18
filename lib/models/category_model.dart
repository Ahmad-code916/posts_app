// ignore_for_file: public_member_api_docs, sort_constructors_first

class CategoryModel {
  final String catName;
  final String catId;
  CategoryModel({required this.catName, required this.catId});

  CategoryModel copyWith({String? catName, String? CatId}) {
    return CategoryModel(
      catName: catName ?? this.catName,
      catId: CatId ?? catId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'catName': catName, 'catId': catId};
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      catName: map['catName'] as String,
      catId: map['catId'] as String,
    );
  }
}
