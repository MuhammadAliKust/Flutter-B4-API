import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_b4_api/providers/loading.dart';
import 'package:flutter_b4_api/providers/user_provider.dart';
import 'package:flutter_b4_api/services/auth.dart';
import 'package:flutter_b4_api/views/profile.dart';
import 'package:flutter_b4_api/views/register.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();

  TextEditingController pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var loadingProvider = Provider.of<LoadingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
          ),
          TextField(
            controller: pwdController,
          ),
          loadingProvider.getLoading()
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ElevatedButton(
                  onPressed: () async {
                    if (emailController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Email cannot be empty.")));
                      return;
                    }
                    if (pwdController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Password cannot be empty.")));
                      return;
                    }
                    try {
                      loadingProvider.setLoading(true);
                      AuthServices()
                          .loginUser(
                              email: emailController.text,
                              password: pwdController.text)
                          .then((val) async {
                        if (val.token != null) {
                          userProvider.setToken(val.token.toString());
                          await AuthServices()
                              .getUserProfile(val.token.toString())
                              .then((val) {
                            loadingProvider.setLoading(false);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProfileView(model: val)));
                          });
                        } else {
                          loadingProvider.setLoading(false);
                        }
                      });
                    } catch (e) {
                      loadingProvider.setLoading(false);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: Text("Login")),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterView()));
              },
              child: Text("Go to Register"))
        ],
      ),
    );
  }
}
