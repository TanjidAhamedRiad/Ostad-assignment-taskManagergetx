import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/UI/Controllers/Home_New_controller.dart';
import 'package:task_manager/UI/Controllers/auth_controller.dart';
import 'package:task_manager/UI/Screen/New_task_screen.dart';
import 'package:task_manager/UI/Widgets/Task_Card.dart';
import 'package:task_manager/UI/Widgets/Task_Summary_Card.dart';

class NewScreen extends StatelessWidget {
  NewScreen({super.key});

  final HomeNewTaskController homeNewTaskController = Get.find<HomeNewTaskController>();
  final taskController = Get.find<HomeNewTaskController>();

  @override
  Widget build(BuildContext context) {
    taskController.fetchNewTaskData();
    taskController.fetchTaskStatusCount();
    AuthController.getUserData();

    return Scaffold(
      body: Column(
        children: [
          Obx(() => buildSummarySection(taskController.statusCountList)),
          Expanded(
            child: Obx(() {
              if (taskController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (taskController.newTaskList.isEmpty) {
                return const Center(child: Text('No tasks available.'));
              }

              return ListView.separated(
                itemCount: taskController.newTaskList.length,
                itemBuilder: (context, index) {
                  return TaskCard(
                    taskData: taskController.newTaskList[index],
                    onRefreshList: taskController.fetchNewTaskData,
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 8,
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onTapNextFAB(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildSummarySection(List statusCountList) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: statusCountList.map((data) {
            return TaskSummary(
              title: data.sId ?? "Unknown",
              count: data.sum ?? 0,
            );
          }).toList(),
        ),
      ),
    );
  }

  void onTapNextFAB(BuildContext context) async {
    final bool? shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewTaskScreen(),
      ),
    );

    if (shouldRefresh == true) {
      taskController.fetchNewTaskData();
    }
  }
}
