import 'package:application_new/third_screen/third_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ThirdScreenController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen Third'),
        backgroundColor: Colors.amberAccent,
      ),
      body: GetBuilder<ThirdScreenController>(
        builder: (context) {
          return Column(
            children: [
              Text('Third Screen'),
              ElevatedButton(
                onPressed: () {
                  controller.getData();
                },
                child: Text('Get Data'),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  controller.deleteDocs();
                },
                child: Text('Delete'),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  controller.update();
                },
                child: Text('Update'),
              ),
              SizedBox(height: 40),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  itemCount: controller.ids.length,
                  itemBuilder: (context, index) {
                    final id = controller.ids[index];
                    return Text(id);
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.dataList.length,
                  itemBuilder: (context, index) {
                    final data = controller.dataList[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.addIdToList(index);
                                },
                                child: Text(data.email),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.showDialog(index);
                                },
                                child: Icon(Icons.update),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
