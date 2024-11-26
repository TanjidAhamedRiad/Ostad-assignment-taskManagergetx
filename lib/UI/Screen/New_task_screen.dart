import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/UI/Controllers/New_task_screen_Controller.dart';
import 'package:task_manager/UI/Widgets/TM_AppBar.dart';

import '../Widgets/Center_Circular_Progress_Indicator.dart';

class NewTaskScreen extends StatelessWidget {
  NewTaskScreen({super.key});

  final NewTaskController newTaskController = Get.find<NewTaskController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.pop(context, newTaskController.refreshPreviousPage.value);
        return false;
      },
      child: Scaffold(
        appBar: TMappBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Add New Task',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: newTaskController.titleCtrl,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Enter title';
                  }
                  return null;
                },
                decoration: const InputDecoration(hintText: 'Title'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: newTaskController.desCtrl,
                maxLines: 5,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Enter descrition';
                  }
                  return null;
                },
                decoration: const InputDecoration(hintText: 'Description'),
              ),
              const SizedBox(
                height: 20,
              ),
              GetBuilder<NewTaskController>(
                builder: (controller) {
                  return Visibility(
                     visible: !controller.IsLoading.value,
                      replacement: const CenterCircularProgressIndicator(),
                      child: ElevatedButton(
                          onPressed: newTaskController.addNewTask,
                          child: const Text("Add Task")));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
