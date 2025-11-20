import 'package:application_new/post_app_screens/profile_details/profile_details_controller.dart';
import 'package:application_new/utils/user_base_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileDetailsController());
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          children: [
            Text('Profile Details', style: TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: GetBuilder<ProfileDetailsController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: CachedNetworkImageProvider(
                          UserBaseController.userData.userImage ?? "",
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text('Name', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: controller.nameController,
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.redAccent,
                          ),
                        ),
                        onPressed: () {
                          controller.updateUserData();
                        },
                        child:
                            controller.isLoading == true
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                  'Update',
                                  style: TextStyle(color: Colors.white),
                                ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.redAccent,
                          ),
                        ),
                        onPressed: () {
                          controller.deleteAccount();
                        },
                        child: Text(
                          'Delete Account',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
