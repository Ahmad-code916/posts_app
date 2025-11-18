import 'package:application_new/models/post_model.dart';
import 'package:application_new/models/user_model_post_app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LikesScreenController extends GetxController {
  String? postId;
  List<UserModelPostApp> users = [];
  List<String> likedByUsers = [];
  bool isLoading = false;
  void getLikesUsers() async {
    try {
      isLoading = true;
      update();
      final post =
          await FirebaseFirestore.instance
              .collection(PostModel.tableName)
              .doc(postId)
              .get();
      if (post.exists) {
        final getPost = PostModel.fromMap(post.data()!);
        likedByUsers = getPost.likedBy ?? [];
        print('^^^^^^^^^^^^^^^^^^^LikedBy${likedByUsers.length}');
        for (var id in likedByUsers) {
          final user =
              await FirebaseFirestore.instance
                  .collection(UserModelPostApp.tableName)
                  .doc(id)
                  .get();
          if (user.exists) {
            final userData = UserModelPostApp.fromMap(user.data()!);
            users.add(userData);
          }
        }
        isLoading = false;
        update();
        print('^^^^^^^^^^^^^^^^^^^^^^^^^users${users.length}');
      }
    } catch (e) {
      isLoading = false;
      update();
      Get.dialog(
        AlertDialog(title: Text('Error'), content: Text(e.toString())),
      );
    }
  }

  @override
  void onInit() {
    postId = Get.arguments['postId'];
    print("^^^^^^^^^^^^^^^$postId");
    getLikesUsers();
    super.onInit();
  }
}
