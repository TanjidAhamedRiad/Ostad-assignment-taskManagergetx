import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/UI/Controllers/progress_screen_controller.dart';
import '../Widgets/Task_Card.dart';


class ProgressScreen extends StatelessWidget {
   ProgressScreen({super.key});
  final ProgressScreenController progressScreenController = Get.find<ProgressScreenController>();
final controller = Get.find<ProgressScreenController>();
  @override
  Widget build(BuildContext context) {
controller.progressedTaskData();

    return Obx(() {
      if (controller.progressTaskInProgress.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (controller.progressTaskList.isEmpty) {
        return const Center(
          child: Text("No tasks found."),
        );
      }

      return ListView.separated(
        itemCount: controller.progressTaskList.length,
        itemBuilder: (context, index) {
          return TaskCard(
            taskData: controller.progressTaskList[index],
            onRefreshList: controller.progressedTaskData,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 8);
        },
      );
    });
  }
}
