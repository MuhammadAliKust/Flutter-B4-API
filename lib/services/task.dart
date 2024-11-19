import 'dart:convert';

import 'package:flutter_b4_api/models/task.dart';
import 'package:flutter_b4_api/models/task_list.dart';
import 'package:http/http.dart' as http;

class TaskServices {
  String baseUrl = "https://todo-nu-plum-19.vercel.app";

  ///Add Task
  Future<TaskModel> addTask(
      {required String description, required String token}) async {
    http.Response response = await http.post(Uri.parse('$baseUrl/todos/add'),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
        body: jsonEncode({"description": description}));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskModel.fromJson(jsonDecode(response.body));
    } else {
      return TaskModel();
    }
  }

  ///Get All Tasks
  Future<TaskListingModel> getAllTasks(String token) async {
    http.Response response = await http.get(Uri.parse('$baseUrl/todos/get'),
        headers: {'Authorization': token});

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskListingModel.fromJson(jsonDecode(response.body));
    } else {
      return TaskListingModel();
    }
  }

  ///Get All Tasks
  Future<TaskListingModel> getCompletedTasks(String token) async {
    http.Response response = await http.get(
        Uri.parse('$baseUrl/todos/completed'),
        headers: {'Authorization': token});

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskListingModel.fromJson(jsonDecode(response.body));
    } else {
      return TaskListingModel();
    }
  }

  ///Get All Tasks
  Future<TaskListingModel> searchTask(
      {required String token, required String searchKey}) async {
    http.Response response = await http.get(
        Uri.parse('$baseUrl/todos/search?keywords=$searchKey'),
        headers: {'Authorization': token});

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskListingModel.fromJson(jsonDecode(response.body));
    } else {
      return TaskListingModel();
    }
  }

  ///Get All Tasks
  Future<TaskListingModel> filterTask(
      {required String token,
      required String startDate,
      required String endDate}) async {
    http.Response response = await http.get(
        Uri.parse(
            '$baseUrl/todos/filter?startDate=$startDate&endDate=$endDate'),
        headers: {'Authorization': token});

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskListingModel.fromJson(jsonDecode(response.body));
    } else {
      return TaskListingModel();
    }
  }

  ///Get All Tasks
  Future<TaskListingModel> getInCompletedTasks(String token) async {
    http.Response response = await http.get(
        Uri.parse('$baseUrl/todos/incomplete'),
        headers: {'Authorization': token});

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskListingModel.fromJson(jsonDecode(response.body));
    } else {
      return TaskListingModel();
    }
  }

  ///Delete Task
  Future<bool> deleteTask(
      {required String taskID, required String token}) async {
    http.Response response = await http.delete(
        Uri.parse('$baseUrl/todos/delete/$taskID'),
        headers: {'Authorization': token});

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  //Update Task
  Future<bool> updateTask(
      {required String description,
      required String token,
      required bool isCompleted,
      required String taskID}) async {
    http.Response response = await http.patch(
        Uri.parse('$baseUrl/todos/update/$taskID'),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
        body:
            jsonEncode({"description": description, "complete": isCompleted}));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
