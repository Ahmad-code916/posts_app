import 'package:application_new/post_app_screens/comment_screen/comment_screen.dart';
import 'package:application_new/post_app_screens/create_post/create_post.dart';
import 'package:application_new/post_app_screens/likes_screen/likes_screen.dart';
import 'package:application_new/post_app_screens/home_screen/home_screen_controller.dart';
import 'package:application_new/post_app_screens/profile_details/profile_details.dart';
import 'package:application_new/utils/user_base_controller.dart';
import 'package:application_new/widgets/flloating_action_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenOneNew extends StatelessWidget {
  const ScreenOneNew({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ScreenOneNewController());
    return Scaffold(
      floatingActionButton: FlloatingActionButton(
        onTap: () {
          Get.to(() => CreatePost());
        },
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => ProfileDetails());
              },
              child: CircleAvatar(
                radius: 25,
                backgroundImage: CachedNetworkImageProvider(
                  UserBaseController.userData.userImage ?? "",
                ),
              ),
            ),
            Text('Posts', style: TextStyle(color: Colors.white)),
            GestureDetector(
              onTap: () {
                controller.logOut();
              },
              child: Icon(Icons.logout, color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: GetBuilder<ScreenOneNewController>(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (controller.posts.isEmpty)
                  Center(
                    child: Text(
                      'No posts Available!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.posts.length,
                      itemBuilder: (context, index) {
                        final posts = controller.posts[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 20),
                          width: Get.width,
                          // height: Get.height * 0.4,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                CachedNetworkImage(
                                  height: 200,
                                  width: Get.width,
                                  imageUrl: posts.postImage ?? "",
                                ),
                                SizedBox(height: 30),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 24,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                            posts.user?.userImage ?? "",
                                          ),
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      children: [
                                        Text(
                                          posts.user?.userName ?? "",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      spacing: 10,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            controller.likePost(index);
                                          },
                                          child:
                                              posts.likedBy!.contains(
                                                    UserBaseController
                                                            .userData
                                                            .id ??
                                                        "",
                                                  )
                                                  ? Icon(
                                                    Icons.favorite,
                                                    color: Colors.red,
                                                  )
                                                  : Icon(
                                                    Icons.favorite_border,
                                                    size: 24,
                                                  ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(
                                              () => LikesScreen(),
                                              arguments: {'postId': posts.id},
                                            );
                                          },
                                          child: Text(
                                            '${posts.likedBy!.length} Likes',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        Get.to(
                                          () => CommentScreen(),
                                          arguments: {
                                            'postUrl': posts.postImage,
                                            'postId': posts.id,
                                          },
                                        );
                                      },
                                      child: Row(
                                        spacing: 10,
                                        children: [
                                          Icon(
                                            Icons.comment_bank_outlined,
                                            size: 23,
                                          ),
                                          Text(
                                            'Comments',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
