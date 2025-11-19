import 'dart:io';
import 'package:application_new/models/user_model_post_app.dart';
import 'package:application_new/post_app_screens/login_screen/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupScreenController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  File? image;
  final supabase = Supabase.instance.client;
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

  void signUp() async {
    if (emailController.text.isEmpty ||
        nameController.text.isEmpty ||
        passwordController.text.isEmpty) {
      Get.dialog(
        AlertDialog(
          title: Text('Error'),
          content: Text('Please enter your personal information.'),
        ),
      );
    } else {
      try {
        isLoading = true;
        update();
        final String url = await uploadImage();
        final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        UserModelPostApp model = UserModelPostApp(
          userName: nameController.text.trim(),
          userImage: url,
          id: user.user?.uid ?? "",
          email: emailController.text.trim(),
        );
        FirebaseFirestore.instance
            .collection(UserModelPostApp.tableName)
            .doc(user.user?.uid ?? "")
            .set(model.toMap());
        emailController.clear();
        nameController.clear();
        passwordController.clear();
        image == null;
        Get.to(() => LoginScreen());
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
