import 'package:application_new/post_app_screens/login_screen/login_screen.dart';
import 'package:application_new/post_app_screens/signup_screen/signup_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupScreenController());
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Signup Screen', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
      ),
      body: GetBuilder<SignupScreenController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Text(
                    'Sign up',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(height: 30),
                  Stack(
                    children: [
                      if (controller.image == null)
                        GestureDetector(
                          onTap: () {
                            controller.pickImage();
                          },
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(500),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Select\nImage',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      if (controller.image != null)
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(controller.image!),
                        ),
                    ],
                  ),
                  TextFormField(
                    onTapOutside: (event) {},
                    decoration: InputDecoration(hintText: 'Name'),
                    controller: controller.nameController,
                    onTapUpOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Email'),
                    controller: controller.emailController,
                    onTapUpOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Password'),
                    controller: controller.passwordController,
                    onTapUpOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.redAccent),
                    ),
                    onPressed: () {
                      controller.signUp();
                    },
                    child:
                        controller.isLoading == true
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                              'Sign up',
                              style: TextStyle(color: Colors.white),
                            ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?'),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => LoginScreen());
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
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
    );
  }
}
