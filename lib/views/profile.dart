import 'package:flutter/material.dart';
import 'package:flutter_b4_api/models/user.dart';
import 'package:flutter_b4_api/views/get_all_tasks.dart';
import 'package:flutter_b4_api/views/get_completed_tasks.dart';
import 'package:flutter_b4_api/views/get_in_completed_tasks.dart';
import 'package:flutter_b4_api/views/search_task.dart';

class ProfileView extends StatelessWidget {
  final UserModel model;

  const ProfileView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GetAllTasksView()));
              },
              icon: Icon(Icons.task)),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchTaskView()));
              },
              icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GetCompletedTasksView()));
              },
              icon: Icon(Icons.comment)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GetInCompletedTasksView()));
              },
              icon: Icon(Icons.abc)),
        ],
      ),
      body: Column(
        children: [
          Text(
            "Name: ${model.user!.name.toString()}",
            style: TextStyle(fontSize: 40),
          ),
          Text(
            "Email: ${model.user!.email.toString()}",
            style: TextStyle(fontSize: 40),
          ),
        ],
      ),
    );
  }
}
