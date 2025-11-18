import 'dart:async';

import 'package:application_new/models/post_model.dart';
import 'package:application_new/post_app_screens/login_screen/login_screen.dart';
import 'package:application_new/utils/user_base_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ScreenOneNewController extends GetxController {
  bool isLoading = false;
  List<PostModel> posts = [];
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? subscription;

  void getPosts() async {
    subscription = FirebaseFirestore.instance
        .collection(PostModel.tableName)
        // .where('user.id', isNotEqualTo: UserBaseController.userData.id ?? "")
        .snapshots()
        .listen((event) {
          if (event.docs.isNotEmpty) {
            posts =
                event.docs.map((e) {
                  return PostModel.fromMap(e.data());
                }).toList();
            update();
            print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^${posts.length}');
          }
        });
  }

  void likePost(int index) async {
    final updatedLikedBy = posts[index].likedBy;
    if (updatedLikedBy!.contains(UserBaseController.userData.id ?? "")) {
      updatedLikedBy.remove(UserBaseController.userData.id ?? "");
    } else {
      updatedLikedBy.add(UserBaseController.userData.id ?? "");
    }
    final model = posts[index].copyWith(likedBy: updatedLikedBy);
    await FirebaseFirestore.instance
        .collection(PostModel.tableName)
        .doc(posts[index].id)
        .set(model.toMap(), SetOptions(merge: true));
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
    Get.off(() => LoginScreen());
  }

  @override
  void onInit() {
    getPosts();
    print('^^^^^^^^^^^^^^^^^^^^^^${UserBaseController.userData.userName}');
    print('^^^^^^^^^^^^^^^^^^^^^^${UserBaseController.userData.userImage}');
    super.onInit();
  }

  @override
  void onClose() async {
    await subscription?.cancel();
    super.onClose();
  }
}
