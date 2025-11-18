import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenOneController extends GetxController {
  List<String> namesList = ['Ahmad', 'Ali', 'Numan'];
  int initialPage = 0;
  Timer? timer;
  PageController pageController = PageController(initialPage: 0);
  void updatePage() {
    if (initialPage < namesList.length) {
      initialPage++;
    } else {
      initialPage = 0;
    }
    pageController.animateToPage(
      initialPage,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInCirc,
    );
    update();
  }

  void goToNextPage() {
    if (initialPage == namesList.length - 1) {
      return;
    } else {
      initialPage = initialPage + 1;
    }
    pageController.animateToPage(
      initialPage,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInCirc,
    );
    update();
  }

  void goToBackPage() {
    if (initialPage == 0) {
      return;
    } else {
      initialPage = initialPage - 1;
    }
    pageController.animateToPage(
      initialPage,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInCirc,
    );
  }

  // @override
  // void onInit() {
  //   timer = Timer.periodic(Duration(seconds: 8), (timer) {
  //     updatePage();
  //   });
  //   super.onInit();
  // }

  @override
  void onClose() {
    pageController.dispose();
    timer?.cancel();
    super.onClose();
  }
}
