import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Data/Models/Network_Response.dart';
import '../../Data/Models/TaskListModel.dart';
import '../../Data/Services/Network_Caller.dart';
import '../../Data/Utils/Urls.dart';

class ProgressScreenController extends GetxController {
  var progressTaskList = <dynamic>[].obs;
  var progressTaskInProgress = false.obs;

  Future<void> progressedTaskData() async {
    progressTaskInProgress.value = true;

    try {
      final NetworkResponse response =
      await NetworkCaller.getRequest(Urls.showProgressedTask);

      if (response.isSuccess) {
        if (response.responseData is Map<String, dynamic>) {
          final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
          progressTaskList.assignAll(taskListModel.tasklist ?? []);
        } else {
          Get.snackbar(
            "Error",
            "Invalid response format",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          response.errorMessage ?? "Unknown error occurred",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "An exception occurred: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    } finally {
      progressTaskInProgress.value = false;
    }
  }
}
