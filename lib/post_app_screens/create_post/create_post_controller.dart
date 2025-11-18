import 'dart:io';
import 'dart:math' as math;
import 'package:application_new/models/post_model.dart';
import 'package:application_new/utils/user_base_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreatePostController extends GetxController {
  File? image;
  final supabase = Supabase.instance.client;
  bool isLoading = false;

  void pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      update();
    } else {
      Get.dialog(
        AlertDialog(title: Text('Error!'), content: Text('No Image Selected.')),
      );
    }
  }

  Future<String> uploadImage() async {
    if (image == null) {
      return "";
    } else {
      try {
        final fileName =
            '${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
        await supabase.storage.from('images').upload(fileName, image!);
        String imageUrl = supabase.storage
            .from('images')
            .getPublicUrl(fileName);
        print('-------------------------->>>>>>>>>>>>>>>>>>>>>>>>>$imageUrl');
        return imageUrl;
      } catch (e) {
        Get.dialog(
          AlertDialog(title: Text('Error!'), content: Text(e.toString())),
        );
        return "";
      }
    }
  }

  void addPost() async {
    try {
      isLoading = true;
      update();
      final String postUrl = await uploadImage();
      final docId = generateRandomId();
      final PostModel model = PostModel(
        id: docId,
        user: UserBaseController.userData,
        postImage: postUrl,
      );
      await FirebaseFirestore.instance
          .collection(PostModel.tableName)
          .doc(docId)
          .set(model.toMap());
      Get.back();
      Get.snackbar('Sent', 'Your post has been sent.');
      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      update();
      Get.dialog(
        AlertDialog(title: Text('Error!'), content: Text(e.toString())),
      );
    }
  }

  static String generateRandomId() {
    const String chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final math.Random random = math.Random();
    return List.generate(
      15,
      (index) => chars[random.nextInt(chars.length)],
    ).join();
  }
}
