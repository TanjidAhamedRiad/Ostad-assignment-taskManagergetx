import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/UI/Controllers/completed_screen_controller.dart';

import '../Widgets/SnackBarMessage.dart';
import '../Widgets/Task_Card.dart';

class CompletedScreen extends StatelessWidget {
  CompletedScreen({super.key});
  static const String name = '/Home_dashboard';

  final CompletedTaskController completedTaskController =
      Get.find<CompletedTaskController>();
  final controller = Get.find<CompletedTaskController>();

  @override
  Widget build(BuildContext context) {
    // Fetch data when the screen is loaded
    controller.fetchCompletedTasks();

    return Obx(
      () {
        // Show loading indicator
        if (controller.completedTaskInProgress.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Show empty message if no tasks
        if (controller.completedTaskList.isEmpty) {
          return const Center(child: Text("No completed tasks found."));
        }

        // Show the list of completed tasks
        return ListView.separated(
          itemCount: controller.completedTaskList.length,
          itemBuilder: (context, index) {
            return TaskCard(
              taskData: controller.completedTaskList[index],
              onRefreshList: controller.fetchCompletedTasks,
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 8),
        );
      },
    );
  }
}
