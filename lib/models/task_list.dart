// To parse this JSON data, do
//
//     final taskListingModel = taskListingModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_b4_api/models/task.dart';

TaskListingModel taskListingModelFromJson(String str) =>
    TaskListingModel.fromJson(json.decode(str));

String taskListingModelToJson(TaskListingModel data) =>
    json.encode(data.toJson());

class TaskListingModel {
  final List<TaskModel>? tasks;
  final int? totalPages;
  final int? currentPage;
  final int? count;

  TaskListingModel({
    this.tasks,
    this.totalPages,
    this.currentPage,
    this.count,
  });

  factory TaskListingModel.fromJson(Map<String, dynamic> json) =>
      TaskListingModel(
        tasks: json["tasks"] == null
            ? []
            : List<TaskModel>.from(
                json["tasks"]!.map((x) => TaskModel.fromJson(x))),
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "tasks": tasks == null
            ? []
            : List<dynamic>.from(tasks!.map((x) => x.toJson())),
        "totalPages": totalPages,
        "currentPage": currentPage,
        "count": count,
      };
}
