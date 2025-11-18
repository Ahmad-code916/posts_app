import 'package:application_new/screen_two/screen_two_controller.dart';
import 'package:application_new/third_screen/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ScreenTwoController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen Two'),
        backgroundColor: Colors.amberAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: GetBuilder<ScreenTwoController>(
          builder: (context) {
            return Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: 'Name'),
                  controller: controller.nameController,
                ),
                SizedBox(height: 30),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Email'),
                  controller: controller.emailController,
                ),
                SizedBox(height: 30),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Category Name'),
                  controller: controller.catNameController,
                ),
                SizedBox(height: 30),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Category Id'),
                  controller: controller.catIdController,
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    controller.saveData();
                  },
                  child: Text('Save Data'),
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => ThirdScreen());
                  },
                  child: Text('Third Screnn'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
