import 'package:flutter/material.dart';
import 'package:flutter_b4_api/models/user.dart';

class ProfileView extends StatelessWidget {
  final UserModel model;

  const ProfileView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
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
