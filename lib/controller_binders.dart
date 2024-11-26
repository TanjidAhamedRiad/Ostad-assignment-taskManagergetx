import 'package:get/get.dart';
import 'package:task_manager/UI/Controllers/Home_New_controller.dart';
import 'package:task_manager/UI/Controllers/New_task_screen_Controller.dart';
import 'package:task_manager/UI/Controllers/Reset_Password_Controller.dart';
import 'package:task_manager/UI/Controllers/completed_screen_controller.dart';
import 'package:task_manager/UI/Controllers/progress_screen_controller.dart';
import 'package:task_manager/UI/Controllers/signIn_Controller.dart';

import 'UI/Controllers/cancelled_screen_controller.dart';
import 'UI/Controllers/forgot_password_email_controller.dart';
import 'UI/Controllers/forgot_password_otp_Controller.dart';

class ControllerBinders extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(SignInController());
    Get.put(SignInController());
    Get.put(ResetPasswordController());
    Get.put(NewTaskController());
    Get.put(ForgotPasswordOtpController());
    Get.put(ForgotPasswordEmailController());
    Get.put(CompletedTaskController());
    Get.put(CancelledScreenController());
    Get.put(HomeNewTaskController());
    Get.put(ProgressScreenController());
  }
}
