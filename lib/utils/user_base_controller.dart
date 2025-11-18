import 'package:application_new/models/user_model_post_app.dart';
import 'package:get/get.dart';

class UserBaseController extends GetxController {
  var userModel = UserModelPostApp();

  static void updateUserModel(UserModelPostApp adminModel) {
    final controller = Get.put(UserBaseController(), permanent: true);
    controller.userModel = adminModel;
    controller.update();
  }

  static UserModelPostApp get userData {
    return Get.put(UserBaseController(), permanent: true).userModel;
  }
}
