import 'package:application_new/models/comment_model..dart';
import 'package:application_new/models/post_model.dart';
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
  List<UserModelPostApp> users = [];
  List<PostModel> posts = [];
  List<PostModel> postsToDelete = [];
  List<CommentModel> comments = [];
  bool isLoading = false;
  String? password;

  void getUsers() async {
    try {
      final user =
          await FirebaseFirestore.instance
              .collection(UserModelPostApp.tableName)
              .get();
      if (user.docs.isNotEmpty) {
        users =
            user.docs.map((e) {
              return UserModelPostApp.fromMap(e.data());
            }).toList();
        update();
      }
    } catch (e) {
      Get.dialog(
        AlertDialog(title: Text('Error'), content: Text(e.toString())),
      );
    }
  }

  void getComments() async {}

  void getPosts() async {
    try {
      final post =
          await FirebaseFirestore.instance
              .collection(PostModel.tableName)
              .get();
      if (post.docs.isNotEmpty) {
        posts =
            post.docs.map((e) {
              return PostModel.fromMap(e.data());
            }).toList();
        update();
      }
    } catch (e) {
      Get.dialog(
        AlertDialog(title: Text('Error'), content: Text(e.toString())),
      );
    }
  }

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
                        for (var e in posts) {
                          List<String> likedBYUpdated = e.likedBy ?? [];
                          if (likedBYUpdated.contains(
                            UserBaseController.userData.id,
                          )) {
                            likedBYUpdated.remove(
                              UserBaseController.userData.id,
                            );
                            await FirebaseFirestore.instance
                                .collection(PostModel.tableName)
                                .doc(e.id)
                                .update({'likedBy': likedBYUpdated});
                          }
                        }
                        deletePosts();
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

  void deletePosts() async {
    postsToDelete =
        posts.where((element) {
          return element.user!.id == UserBaseController.userData.id;
        }).toList();
    for (var i in postsToDelete) {
      await FirebaseFirestore.instance
          .collection(PostModel.tableName)
          .doc(i.id)
          .delete();
    }
  }

  @override
  void onInit() {
    getUsers();
    getPosts();
    nameController.text = UserBaseController.userData.userName ?? "";
    super.onInit();
  }
}
