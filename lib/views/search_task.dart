import 'package:flutter/material.dart';
import 'package:flutter_b4_api/models/task_list.dart';
import 'package:flutter_b4_api/providers/user_provider.dart';
import 'package:flutter_b4_api/services/task.dart';
import 'package:provider/provider.dart';

class SearchTaskView extends StatefulWidget {
  SearchTaskView({super.key});

  @override
  State<SearchTaskView> createState() => _SearchTaskViewState();
}

class _SearchTaskViewState extends State<SearchTaskView> {
  TaskListingModel? model;

  TextEditingController controller = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Task"),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
            onSubmitted: (val) async {
              isLoading = true;
              setState(() {});
              await TaskServices()
                  .searchTask(
                      token: userProvider.getToken().toString(),
                      searchKey: controller.text)
                  .then((val) {
                isLoading = false;
                model = val;
                setState(() {});
              });
            },
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
          if (model != null)
            Expanded(
              child: ListView.builder(
                  itemCount: model!.tasks!.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text(model!.tasks![i].description.toString()),
                    );
                  }),
            ),
        ],
      ),
    );
  }
}
