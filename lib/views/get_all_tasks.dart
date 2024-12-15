import 'package:flutter/material.dart';
import 'package:flutter_b4_api/models/task_list.dart';
import 'package:flutter_b4_api/services/task.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class GetAllTasksView extends StatefulWidget {
  GetAllTasksView({super.key});

  @override
  State<GetAllTasksView> createState() => _GetAllTasksViewState();
}

class _GetAllTasksViewState extends State<GetAllTasksView> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Tasks"),
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: FutureProvider.value(
            value:
                TaskServices().getAllTasks(userProvider.getToken().toString()),
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
                          title: Text(taskListingModel.tasks![i].description
                              .toString()),
                          leading: Icon(Icons.task),
                          trailing: IconButton(
                              onPressed: () async {
                                isLoading = true;
                                setState(() {});
                                await TaskServices()
                                    .deleteTask(
                                        taskID: taskListingModel.tasks![i].id
                                            .toString(),
                                        token:
                                            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NmM1YWVjMzRjZTRmNDBjNWFiNzljYzIiLCJpYXQiOjE3MzIwOTc0MTF9.CdlSMM00RAb8CmL7qMFZxUEvq-CEIydNEO1ca_mUBkw')
                                    .then((val) {
                                  isLoading = false;
                                  setState(() {});
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Task has been deleted succesfully")));
                                });
                              },
                              icon: Icon(Icons.delete)),
                        );
                      });
            }),
      ),
    );
  }
}
