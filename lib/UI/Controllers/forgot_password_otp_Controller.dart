import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../Data/Models/Network_Response.dart';
import '../../Data/Services/Network_Caller.dart';
import '../../Data/Utils/Urls.dart';
import '../Screen/Reset_Passowrd_screen.dart';
import '../Screen/SignInScreen.dart';

class ForgotPasswordOtpController extends GetxController {
  final TextEditingController otpCtrl = TextEditingController();
  var otpInProgress = false.obs;

  Future<void> verifyOtp(String email) async {
    otpInProgress.value = true;

    final NetworkResponse response =
    await NetworkCaller.getRequest(Urls.recoverVerifyOtp(email, otpCtrl.text));

    otpInProgress.value = false;

    if (response.isSuccess) {
      Get.snackbar('Success', 'Verification Done',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
      Get.to(() => ResetPasswordScreen(email: email, otp: otpCtrl.text));
    } else {
      Get.snackbar('Error', 'Invalid code',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
  }

  void navigateToSignIn() {
    Get.offAll(() => const SignInScreen());
  }
}
