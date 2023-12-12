import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PracticeApi extends StatefulWidget {
  const PracticeApi({Key? key}) : super(key: key);

  @override
  State<PracticeApi> createState() => _PracticeApiState();
}

class _PracticeApiState extends State<PracticeApi> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  Future Login({required String email, required String pass}) async {
    final response = await http.post(
      Uri.parse("https://uis.sataware.dev/api/login"),
      body: {"email": email, "password": pass},
    );

    if (response.statusCode == 200) {
      final responceData = await jsonDecode(response.body);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(responceData["status"]),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
        child: Column(
          children: [
            TextField(
              controller: emailcontroller,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            TextField(
              controller: passcontroller,
              decoration: InputDecoration(
                labelText: "Passwprd",
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Login(email: emailcontroller.text, pass: passcontroller.text);
              },
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
