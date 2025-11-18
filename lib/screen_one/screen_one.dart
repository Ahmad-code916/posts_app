import 'package:application_new/screen_one/screen_one_controller.dart';
import 'package:application_new/screen_two/screen_two.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenOne extends StatelessWidget {
  ScreenOne({super.key});

  final ScreenOneController controller = Get.put(ScreenOneController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen One'),
        backgroundColor: Colors.amberAccent,
      ),
      body: GetBuilder<ScreenOneController>(
        builder: (context) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('Screen One'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => ScreenTwo());
                    },
                    child: Text('Screen Two'),
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: controller.pageController,
                      itemCount: controller.namesList.length,
                      itemBuilder: (context, index) {
                        final name = controller.namesList[index];
                        return Center(
                          child: Text(
                            name,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.goToBackPage();
                        },
                        child: Icon(Icons.arrow_back),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.goToNextPage();
                        },
                        child: Icon(Icons.forward),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
