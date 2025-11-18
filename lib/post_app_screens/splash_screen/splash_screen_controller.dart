import 'dart:async';
import 'package:application_new/models/user_model_post_app.dart';
import 'package:application_new/post_app_screens/login_screen/login_screen.dart';
import 'package:application_new/post_app_screens/screen_one/screen_one_new.dart';
import 'package:application_new/utils/user_base_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    Future.delayed(Duration(seconds: 3), () async {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        Get.offAll(() => LoginScreen());
      } else {
        print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^${currentUser.uid}');
        final userId = currentUser.uid;
        final user =
            await FirebaseFirestore.instance
                .collection(UserModelPostApp.tableName)
                .doc(userId)
                .get();
        print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^66${user.id}');
        if (user.exists) {
          UserBaseController.updateUserModel(
            UserModelPostApp.fromMap(user.data()!),
          );
          Get.offAll(() => ScreenOneNew());
        } else {
          Get.offAll(() => LoginScreen());
        }
      }
    });
    super.onInit();
  }
}
