import 'package:application_new/models/user_model_post_app.dart';
import 'package:application_new/post_app_screens/screen_one/screen_one_new.dart';
import 'package:application_new/utils/user_base_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  bool isLoading = false;

  void login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.dialog(
        AlertDialog(
          title: Text('Error'),
          content: Text('Please enter your credentials.'),
        ),
      );
    } else {
      try {
        isLoading = true;
        update();
        final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        final currentUser =
            await FirebaseFirestore.instance
                .collection(UserModelPostApp.tableName)
                .doc(user.user?.uid ?? "")
                .get();
        if (currentUser.exists) {
          UserBaseController.updateUserModel(
            UserModelPostApp.fromMap(currentUser.data()!),
          );
        }
        Get.offAll(() => ScreenOneNew());
        isLoading = false;
        update();
      } catch (e) {
        isLoading = false;
        update();
        Get.dialog(
          AlertDialog(title: Text('Error'), content: Text(e.toString())),
        );
      }
    }
  }
}
