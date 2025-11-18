import 'package:application_new/post_app_screens/comment_screen/comment_screen_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CommentScreenController());
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          children: [Text('Comment', style: TextStyle(color: Colors.white))],
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: SafeArea(
        child: GetBuilder<CommentScreenController>(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CachedNetworkImage(
                              imageUrl: controller.postUrl ?? "",
                              height: Get.height * 0.4,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'All Comments',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 20),
                          if (controller.comments.isEmpty)
                            Center(
                              child: Text(
                                'No Comment!',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          else
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.comments.length,
                              itemBuilder: (context, index) {
                                final comment = controller.comments[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                              comment.senderData?.userImage ??
                                                  "",
                                            ),
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              comment.senderData?.userName ??
                                                  "",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(comment.comment ?? ""),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          onChanged: controller.onChange,
                          controller: controller.commentController,
                          decoration: InputDecoration(hintText: 'Add Comment'),
                        ),
                      ),
                      if (controller.commentController.text.isNotEmpty)
                        GestureDetector(
                          onTap: () {
                            controller.sendComment();
                          },
                          child: Icon(Icons.send, color: Colors.redAccent),
                        ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
