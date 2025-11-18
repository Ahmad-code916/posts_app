import 'dart:async';

import 'package:application_new/models/category_model.dart';
import 'package:application_new/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThirdScreenController extends GetxController {
  List<UserModel> dataList = [];
  List<CategoryModel> categories = [];
  List<String> ids = [];
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? subscription;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController catNameController = TextEditingController();
  TextEditingController catIdController = TextEditingController();

  void getData() async {
    subscription = FirebaseFirestore.instance
        .collection(UserModel.tableName)
        .snapshots()
        .listen((event) {
          if (event.docs.isNotEmpty) {
            dataList =
                event.docs.map((e) {
                  return UserModel.fromMap(e.data());
                }).toList();
            update();
          }
        });
  }

  void addIdToList(int index) {
    if (ids.contains(dataList[index].id)) {
      ids.remove(dataList[index].id);
    } else {
      ids.add(dataList[index].id);
    }
    update();
  }

  void deleteDocs() async {
    for (var e in ids) {
      await FirebaseFirestore.instance
          .collection(UserModel.tableName)
          .doc(e)
          .delete();
    }
    Get.snackbar('Deleted!', 'All users deleted');
  }

  void updateDoc(int index) async {
    List<CategoryModel> catModel = [
      CategoryModel(catName: 'first', catId: '434'),
      CategoryModel(catName: 'Second', catId: '2434'),
    ];
    await FirebaseFirestore.instance
        .collection(UserModel.tableName)
        .doc(dataList[index].id)
        .set(
          UserModel(
            email: 'new@gmail.com',
            name: 'new',
            id: dataList[index].id,
            cateories: catModel,
          ).copyWith().toMap(),
          SetOptions(merge: true),
        );
    Get.back();
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  @override
  void onClose() {
    subscription?.cancel();
    super.onClose();
  }

  void showDialog(int index) {
    Get.dialog(
      AlertDialog(
        title: Text('Update'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(hintText: 'Name'),
              controller: nameController,
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(hintText: 'Email'),
              controller: emailController,
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(hintText: 'Category Name'),
              controller: catNameController,
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(hintText: 'Category Id'),
              controller: catIdController,
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 15,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Text('Cancel'),
                ),
                GestureDetector(
                  onTap: () {
                    updateDoc(index);
                  },
                  child: Text('Update'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
