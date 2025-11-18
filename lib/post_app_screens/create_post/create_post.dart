import 'package:application_new/post_app_screens/create_post/create_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePost extends StatelessWidget {
  const CreatePost({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreatePostController());
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          children: [Text('Posts', style: TextStyle(color: Colors.white))],
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GetBuilder<CreatePostController>(
          builder: (context) {
            return SizedBox(
              width: Get.width,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      controller.pickImage();
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.redAccent),
                    ),
                    child: Text(
                      'Select Image',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                  if (controller.image != null)
                    Column(
                      children: [
                        Image.file(
                          controller.image!,
                          height: 200,
                          width: Get.width,
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            controller.addPost();
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Colors.redAccent,
                            ),
                          ),
                          child:
                              controller.isLoading == true
                                  ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : Text(
                                    'Upload Image',
                                    style: TextStyle(color: Colors.white),
                                  ),
                        ),
                      ],
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
