import 'package:flutter/material.dart';
import 'package:task_manager/UI/Controllers/Home_New_controller.dart';
import 'package:task_manager/UI/Controllers/auth_controller.dart';
import 'package:task_manager/UI/Screen/New_task_screen.dart';
import 'package:task_manager/UI/Widgets/Center_Circular_Progress_Indicator.dart';
import 'package:task_manager/UI/Widgets/Task_Summary_Card.dart';
import '../../Data/Models/StatusCountModel.dart';
import '../Widgets/Task_Card.dart';
import 'package:get/get.dart';

class NewScreen extends StatelessWidget {
  NewScreen({super.key});
  final HomeNewTaskController homeNewTaskController =
      Get.find<HomeNewTaskController>();
  @override
  Widget build(BuildContext context) {
    homeNewTaskController.fetchNewTaskData();
    homeNewTaskController.fetchTaskStatusCount();
    AuthController.getUserData();
    return Scaffold(
      body: Column(
        children: [
         // buildSummarySection(),
          Expanded(
            child: Obx(() {
              if (homeNewTaskController.isLoading.value) {
                return const Center(child: CenterCircularProgressIndicator());
              }
              if (homeNewTaskController.newTaskList.isEmpty) {
                return const Center(child: Text("No Tasl Available"));
              }
              return ListView.separated(
                itemCount: homeNewTaskController.newTaskList.length,
                itemBuilder: (context, index) {
                  return TaskCard(
                      taskData: homeNewTaskController.newTaskList[index],
                      onRefreshList: homeNewTaskController.fetchNewTaskData);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 8,
                  );
                },
              );
            }),
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: onTapNextFAB,
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  // Widget buildSummarySection( List statusCountList) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: SingleChildScrollView(
  //       scrollDirection: Axis.horizontal,
  //       child: Row(
  //         children: statusCountList.map((data){
  //           return TaskSummary(title: data.si,);
  //         })
  //       ),
  //     ),
  //   );
  // }
  //
  //
  // void onTapNextFAB() async {
  //   final bool? shouldRefresh = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => NewTaskScreen(),
  //     ),
  //   );
  //
  //   if (shouldRefresh == true) {
  //     getNewTaskData();
  //   }
  // }
}
