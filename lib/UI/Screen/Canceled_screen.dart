import 'package:flutter/material.dart';
import 'package:task_manager/UI/Controllers/cancelled_screen_controller.dart';
import 'package:task_manager/UI/Widgets/Center_Circular_Progress_Indicator.dart';

import '../Controllers/completed_screen_controller.dart';
import '../Widgets/Task_Card.dart';
import 'package:get/get.dart';

class CancelScreen extends StatelessWidget {
  CancelScreen({super.key});

  final CancelledScreenController cancelledScreenController =
      Get.find<CancelledScreenController>();
  final controller = Get.find<CancelledScreenController>();

  @override
  Widget build(BuildContext context) {
    controller.fetchCancelledTask();
    return Obx(() {
      if (controller.cancelledTaskInProgress.value) {
        return const Center(child: CenterCircularProgressIndicator());
      }
      if (controller.canceledTaskList.isEmpty) {
        return const Center(child: Text("No completed tasks found."));
      }
      return ListView.separated(
        itemCount: controller.canceledTaskList.length,
        itemBuilder: (context, index) {
          return TaskCard(
            taskData: controller.canceledTaskList[index],
            onRefreshList: controller.fetchCancelledTask,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 8,
          );
        },
      );
    });
  }
}
