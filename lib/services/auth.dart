import 'dart:convert';
import 'dart:developer';

import 'package:flutter_b4_api/models/register.dart';
import 'package:flutter_b4_api/models/token.dart';
import 'package:flutter_b4_api/models/user.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  String baseUrl = "https://todo-nu-plum-19.vercel.app";

  ///Register User
  Future<RegisterModel> registerUser(
      {required String name,
      required String email,
      required String password}) async {
    http.Response response = await http.post(
        Uri.parse('$baseUrl/users/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password, "name": name}));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return RegisterModel.fromJson(jsonDecode(response.body));
    } else {
      return RegisterModel();
    }
  }

  ///Login User
  Future<TokenModel> loginUser(
      {required String email, required String password}) async {
    http.Response response = await http.post(Uri.parse('$baseUrl/users/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}));
    log(response.statusCode.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      return TokenModel.fromJson(jsonDecode(response.body));
    } else {
      return TokenModel();
    }
  }

  ///Login User
  Future updateProfile({required String token, required String name}) async {
    http.Response response = await http.post(Uri.parse('$baseUrl/users/login'),
        body: jsonEncode({"name": name}));
    return;
  }

  ///Get User Profile
  Future<UserModel> getUserProfile(String token) async {
    http.Response response = await http.get(Uri.parse('$baseUrl/users/profile'),
        headers: {'Authorization': token});

    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      return UserModel();
    }
  }
}
