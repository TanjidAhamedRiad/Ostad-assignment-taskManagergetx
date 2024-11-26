import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Data/Models/Network_Response.dart';
import '../../Data/Services/Network_Caller.dart';
import '../../Data/Utils/Urls.dart';

class NewTaskController extends GetxController {
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController desCtrl = TextEditingController();


  final IsLoading = false.obs;

  final refreshPreviousPage = false.obs;

  Future<void> addNewTask() async {
    if (titleCtrl.text.trim().isEmpty || desCtrl.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "All fields are required",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    IsLoading.value = true;

    Map<String, dynamic> requestBody = {
      "title": titleCtrl.text.trim(),
      "description": desCtrl.text.trim(),
      "status": "New"
    };

    NetworkResponse response =
        await NetworkCaller.postRequest(Urls.creatTask, requestBody);
    IsLoading.value = false;

    if (response.isSuccess) {
      refreshPreviousPage.value = true;
      clearTaskData();
      Get.snackbar('Success', 'New task added!',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
    } else {
      Get.snackbar("Error", response.errorMessage ?? "Something went wrong",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
  }

  void clearTaskData() {
    titleCtrl.clear();
    desCtrl.clear();
  }
}
