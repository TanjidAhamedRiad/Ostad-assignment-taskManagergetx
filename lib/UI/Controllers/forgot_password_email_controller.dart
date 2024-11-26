import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/UI/Screen/Forgot_Password_OTP_Screen.dart';

import '../../Data/Models/Network_Response.dart';
import '../../Data/Services/Network_Caller.dart';
import '../../Data/Utils/Urls.dart';

class ForgotPasswordEmailController extends GetxController{

  final TextEditingController emailCtrl = TextEditingController();
  var emailInProgress = false.obs;


  Future<void> sendOTP() async {
    emailInProgress.value = true;

    final NetworkResponse response = await NetworkCaller.getRequest(
        Urls.recoveryVarifiedEmail(emailCtrl.text));

    emailInProgress.value =false;

    if (response.isSuccess) {
     Get.snackbar("Success", "OTP has been sent",  snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
     Get.to(ForgotPasswordOtpScreen(email: emailCtrl.text));
    } else {
     Get.snackbar("Error", response.errorMessage,);
    }
  }

  void onTapSignIn() {
    Get.back();
  }
}
