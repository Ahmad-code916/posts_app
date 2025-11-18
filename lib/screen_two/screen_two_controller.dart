import 'dart:math' as math;
import 'package:application_new/models/category_model.dart';
import 'package:application_new/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ScreenTwoController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController catNameController = TextEditingController();
  TextEditingController catIdController = TextEditingController();

  String getnerateRandomId() {
    const String chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final math.Random random =
        math.Random(); // Use math.Random() instead of Random()
    return List.generate(
      15,
      (index) => chars[random.nextInt(chars.length)],
    ).join();
  }

  void saveData() async {
    String docId = getnerateRandomId();
    // final catModel = CategoryModel(
    //   catName: catNameController.text.trim(),
    //   catId: catIdController.text.trim(),
    // );
    List<CategoryModel> catModel = [
      CategoryModel(catName: 'first', catId: '434'),
      CategoryModel(catName: 'Second', catId: '2434'),
    ];
    await FirebaseFirestore.instance
        .collection(UserModel.tableName)
        .doc(docId)
        .set(
          UserModel(
            email: emailController.text.trim(),
            name: nameController.text.trim(),
            id: docId,
            cateories: catModel,
          ).toMap(),
        );
    Get.snackbar('Sent', 'Data sent successfully');
  }
}
