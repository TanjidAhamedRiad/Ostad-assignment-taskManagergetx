import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Data/Models/Network_Response.dart';
import '../../Data/Services/Network_Caller.dart';
import '../../Data/Utils/Urls.dart';

class SignUpController extends GetxController {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  Future<void> signUp() async {
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": emailCtrl.text.trim(),
      "firstName": firstNameCtrl.text.trim(),
      "lastName": lastNameCtrl.text.trim(),
      "mobile": phoneCtrl.text.trim(),
      "password": passCtrl.text.trim(),
      "photo": ""
    };

    NetworkResponse response =
        await NetworkCaller.postRequest(Urls.registration, requestBody);

    _inProgress = false;
    update();

    if (response.isSuccess) {
      clearTextField();
      Get.snackbar(
        'Success',
        'New user created',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
  }

  void clearTextField() {
    emailCtrl.clear();
    firstNameCtrl.clear();
    lastNameCtrl.clear();
    phoneCtrl.clear();
    passCtrl.clear();
  }
  @override
  void onClose() {
    emailCtrl.dispose();
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    phoneCtrl.dispose();
    passCtrl.dispose();
    super.onClose();
  }
}
