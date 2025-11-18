import 'package:application_new/post_app_screens/likes_screen/likes_screen_controller.dart';
import 'package:application_new/utils/user_base_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LikesScreen extends StatelessWidget {
  const LikesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LikesScreenController());
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          children: [Text('Likes', style: TextStyle(color: Colors.white))],
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: GetBuilder<LikesScreenController>(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child:
                controller.isLoading == true
                    ? Center(
                      child: CircularProgressIndicator(color: Colors.redAccent),
                    )
                    : ListView.builder(
                      itemCount: controller.users.length,
                      itemBuilder: (context, index) {
                        final user = controller.users[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: CachedNetworkImageProvider(
                                  user.userImage ?? "",
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.userName ?? "",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    // Text(UserBaseController.userData.userName ?? ""),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
          );
        },
      ),
    );
  }
}
