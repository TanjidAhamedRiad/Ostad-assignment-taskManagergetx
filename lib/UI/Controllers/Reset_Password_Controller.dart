import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Data/Models/Network_Response.dart';
import '../../Data/Services/Network_Caller.dart';
import '../../Data/Utils/Urls.dart';

class ResetPasswordController extends GetxController {
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _recoveryPassInProgress = false.obs;
  final _errorMessage = RxnString();

  bool get recoveryPassInProgress => _recoveryPassInProgress.value;

  Future<void> changePassword(
      String email,
      String? otp,
      String password,
      {
        required VoidCallback onSuccess,
        required Function(String message) onError,
      }) async {
    _recoveryPassInProgress.value = true;

    Map<String, dynamic> requestBody = {
      "email": email,
      "OTP": otp,
      "password": password,
    };

    final NetworkResponse response =
    await NetworkCaller.postRequest(Urls.recoverResetPassword, requestBody);

    _recoveryPassInProgress.value = false;

    if (response.isSuccess) {
      onSuccess();
    } else {
      _errorMessage.value = response.errorMessage;
      onError(response.errorMessage ?? "An error occurred");
    }
  }

  @override
  void onClose() {
    // Dispose of controllers when the controller is closed
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.onClose();
  }
}
