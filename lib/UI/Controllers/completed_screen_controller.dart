import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Data/Models/Network_Response.dart';
import '../../Data/Models/TaskListModel.dart';
import '../../Data/Services/Network_Caller.dart';
import '../../Data/Utils/Urls.dart';

class CompletedTaskController extends GetxController {

  var completedTaskInProgress = false.obs; // Declare it as an observable
  var completedTaskList = <dynamic>[].obs; // Observable list

  Future<void> fetchCompletedTasks() async {
    completedTaskInProgress.value = true;

    try {
      final NetworkResponse response =
      await NetworkCaller.getRequest(Urls.showCompletedTask);

      if (response.isSuccess) {
        // Ensure responseData is not null and is a Map
        if (response.responseData != null && response.responseData is Map<String, dynamic>) {
          final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData as Map<String, dynamic>);
          completedTaskList.assignAll(taskListModel.tasklist ?? []);
        } else {
          Get.snackbar(
            "Error",
            "Unexpected data format received from the server",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          response.errorMessage ?? "Unknown error occurred",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "An exception occurred: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
    } finally {
      completedTaskInProgress.value = false;
    }
  }

}




