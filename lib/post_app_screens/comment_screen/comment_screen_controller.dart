import 'dart:async';
import 'package:application_new/models/comment_model..dart';
import 'package:application_new/models/post_model.dart';
import 'package:application_new/utils/app_functions.dart';
import 'package:application_new/utils/user_base_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentScreenController extends GetxController {
  String? postUrl;
  String? postId;
  List<CommentModel> comments = [];
  TextEditingController commentController = TextEditingController();
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? subscription;

  void onChange(String? text) {
    commentController.text = text ?? "";
    update();
  }

  void getComments() async {
    try {
      subscription = FirebaseFirestore.instance
          .collection(PostModel.tableName)
          .doc(postId)
          .collection(CommentModel.tableName)
          .snapshots()
          .listen((event) {
            if (event.docs.isNotEmpty) {
              comments =
                  event.docs.map((e) {
                    return CommentModel.fromMap(e.data());
                  }).toList();
              update();
            }
          });
    } catch (e) {
      Get.dialog(
        AlertDialog(title: Text('Error'), content: Text(e.toString())),
      );
    }
  }

  void sendComment() async {
    try {
      final docId = AppFunctions.generateRandomId();
      final commentModel = CommentModel(
        comment: commentController.text.trim(),
        senderId: UserBaseController.userData.id,
        senderData: UserBaseController.userData,
      );
      await FirebaseFirestore.instance
          .collection(PostModel.tableName)
          .doc(postId)
          .collection(CommentModel.tableName)
          .doc(docId)
          .set(commentModel.toMap());
      commentController.clear();
      update();
    } catch (e) {
      Get.dialog(
        AlertDialog(title: Text('Error'), content: Text(e.toString())),
      );
    }
  }

  @override
  void onInit() {
    postUrl = Get.arguments['postUrl'];
    postId = Get.arguments['postId'];
    print('^^^^^^^^^^^^^^^^^^^^^^^^^^$postUrl');
    print('^^^^^^^^^^^^^^^^^^^^^^^^^^$postId');
    getComments();
    super.onInit();
  }

  @override
  void onClose() async {
    await subscription?.cancel();
    super.onClose();
  }
}
