// To parse this JSON data, do
//
//     final tokenModel = tokenModelFromJson(jsonString);

import 'dart:convert';

TokenModel tokenModelFromJson(String str) =>
    TokenModel.fromJson(json.decode(str));

String tokenModelToJson(TokenModel data) => json.encode(data.toJson());

class TokenModel {
  final String? token;
  final String? message;
  final bool? status;

  TokenModel({
    this.token,
    this.message,
    this.status,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        token: json["token"],
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "message": message,
        "status": status,
      };
}
