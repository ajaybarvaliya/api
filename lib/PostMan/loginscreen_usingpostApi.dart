import 'dart:convert';

import 'package:api/Model/Responce/Posts/post_responce.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool Loading = false;
  bool hasherror = false;

  Future login({required String email, required String pass}) async {
    setState(() {
      Loading = true;
    });
    final response = await http.post(
      Uri.parse("https://uis.sataware.dev/api/login"),
      body: {
        "email": email,
        "password": pass,
      },
    );

    if (response.statusCode == 200) {
      // LoginPost loginPost = LoginPost.fromJson(jsonDecode(response.body));
      final responseData = jsonDecode(response.body);
      // print("StatusCode ${responseData.body["status"]}");
      setState(() {
        Loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(responseData["status"]),
        ),
      );
    }
    // else {
    //   print("StatusCode ${response.statusCode}");
    //
    //   setState(
    //     () {
    //       Loading = false;
    //       hasherror = true;
    //     },
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            TextField(
              controller: email,
              decoration: const InputDecoration(
                labelText: "email",
              ),
            ),
            TextField(
              controller: password,
              decoration: const InputDecoration(
                labelText: "password",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                login(email: email.text, pass: password.text);
              },
              child: Loading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    )
                  : Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
