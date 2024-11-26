import 'package:get/get.dart';
import 'package:task_manager/Data/Models/Network_Response.dart';
import 'package:task_manager/Data/Models/StatusCountModel.dart';
import 'package:task_manager/Data/Models/TaskListModel.dart';
import 'package:task_manager/Data/Services/Network_Caller.dart';
import 'package:task_manager/Data/Utils/Urls.dart';

import '../../Data/Models/TaskModel.dart';

class HomeNewTaskController extends GetxController {
  var isLoading = false.obs;
  var newTaskList = <TaskData>[].obs;
  var statusCountList = <Data>[].obs;

  Future<void> fetchNewTaskData() async {
    isLoading.value = true;

    try {
      NetworkResponse response = await NetworkCaller.getRequest(Urls.showNewTask);

      if (response.isSuccess) {
        final TaskListModel taskListModel = TaskListModel.fromJson(response.responseData);
        newTaskList.value = taskListModel.tasklist ?? [];
      } else {
        Get.snackbar('Error', response.errorMessage, snackPosition: SnackPosition.BOTTOM);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchTaskStatusCount() async {
    // Implement this similar to `fetchNewTaskData` to populate `statusCountList`.
    // Example:
    isLoading.value = true;

    try {
      NetworkResponse response = await NetworkCaller.getRequest(Urls.taskStatusCount);

      if (response.isSuccess) {
        final StatusCountModel statusCountModel = StatusCountModel.fromJson(response.responseData);
        statusCountList.value = statusCountModel.statusCountData ?? [];
      } else {
        Get.snackbar('Error', response.errorMessage, snackPosition: SnackPosition.BOTTOM);
      }
    } finally {
      isLoading.value = false;
    }
  }
}

