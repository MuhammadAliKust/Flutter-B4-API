import 'package:flutter/material.dart';
import 'package:flutter_b4_api/models/task_list.dart';
import 'package:flutter_b4_api/services/task.dart';
import 'package:provider/provider.dart';

class GetAllTasksView extends StatelessWidget {
  const GetAllTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Tasks"),
      ),
      body: FutureProvider.value(
          value: TaskServices().getAllTasks(
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NmM1YWVjMzRjZTRmNDBjNWFiNzljYzIiLCJpYXQiOjE3MzIwOTc0MTF9.CdlSMM00RAb8CmL7qMFZxUEvq-CEIydNEO1ca_mUBkw'),
          initialData: TaskListingModel(),
          builder: (context, child) {
            TaskListingModel taskListingModel =
                context.watch<TaskListingModel>();
            return taskListingModel.tasks == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: taskListingModel.tasks!.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text(taskListingModel.tasks![i].
                            description.toString()),
                        leading: Icon(Icons.task),
                      );
                    });
          }),
    );
  }
}
