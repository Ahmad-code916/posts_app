import 'package:application_new/models/user_model_post_app.dart';
import 'package:application_new/post_app_screens/login_screen/login_screen.dart';
import 'package:application_new/utils/user_base_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProfileDetailsController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String? password;

  void updateUserData() async {
    try {
      isLoading = true;
      update();
      await FirebaseFirestore.instance
          .collection(UserModelPostApp.tableName)
          .doc(UserBaseController.userData.id)
          .update({'userName': nameController.text});
      final user =
          await FirebaseFirestore.instance
              .collection(UserModelPostApp.tableName)
              .doc(UserBaseController.userData.id)
              .get();
      if (user.exists) {
        UserBaseController.updateUserModel(
          UserModelPostApp.fromMap(user.data()!),
        );
      }
      Get.back();
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

  void deleteAccount() async {
    try {
      Get.dialog(
        AlertDialog(
          title: Text('Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(hintText: 'Password'),
              ),
              SizedBox(height: 20),
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
                    onTap: () async {
                      if (passwordController.text.isEmpty) {
                        Get.dialog(
                          AlertDialog(
                            title: Text('Error'),
                            content: Text('Please enter your password.'),
                          ),
                        );
                      } else {
                        password = passwordController.text.trim();
                        final user = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                              email: UserBaseController.userData.email ?? "",
                              password: password ?? "",
                            );
                        await FirebaseFirestore.instance
                            .collection(UserModelPostApp.tableName)
                            .doc(UserBaseController.userData.id)
                            .delete();
                        await FirebaseAuth.instance.currentUser!.delete();
                        Get.offAll(() => LoginScreen());
                        update();
                      }
                    },

                    child: Text(
                      'Confirm',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      Get.dialog(
        AlertDialog(title: Text('Error'), content: Text(e.toString())),
      );
    }
  }

  @override
  void onInit() {
    nameController.text = UserBaseController.userData.userName ?? "";
    super.onInit();
  }
}
