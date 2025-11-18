import 'package:application_new/post_app_screens/login_screen/login_screen_controller.dart';
import 'package:application_new/post_app_screens/signup_screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginScreenController());
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Login Screen', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
      ),
      body: GetBuilder<LoginScreenController>(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 30),
                Text(
                  'Login',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                SizedBox(height: 30),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Email'),
                  controller: controller.emailController,
                ),
                SizedBox(height: 30),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Password'),
                  controller: controller.passwordController,
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.redAccent),
                  ),
                  onPressed: () {
                    controller.login();
                  },
                  child:
                      controller.isLoading == true
                          ? CircularProgressIndicator()
                          : Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?'),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => SignupScreen());
                      },
                      child: Text(
                        'Sign up',
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
          );
        },
      ),
    );
  }
}
