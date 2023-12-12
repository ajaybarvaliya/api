import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Respocemodel.dart';

// class UisGet extends StatefulWidget {
//   const UisGet({Key? key}) : super(key: key);
//
//   @override
//   State<UisGet> createState() => _UisGetState();
// }
//
// class _UisGetState extends State<UisGet> {
//   var data;
//   Future getData() async {
//     http.Response response =
//         await http.get(Uri.parse("https://dummyjson.com/products/4"));
//
//     if (response.statusCode == 200) {
//       data = jsonDecode(response.body);
//       print("RESPONSE ${response.body}");
//     } else {
//       print("RESPONSE ${response.statusCode}");
//     }
//
//     return data;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: getData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return Center(child: Text("${snapshot.data["title"]}"));
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }

class UisGet extends StatefulWidget {
  const UisGet({Key? key}) : super(key: key);

  @override
  State<UisGet> createState() => _UisGetState();
}

class _UisGetState extends State<UisGet> {
  var data;
  Future<GetProduct?> getData() async {
    GetProduct? getProduct;
    http.Response response =
        await http.get(Uri.parse("https://dummyjson.com/products/4"));

    if (response.statusCode == 200) {
      getProduct = getProductFromJson(response.body);
      print("RESPONSE ${response.body}");
    } else {
      print("RESPONSE ${response.statusCode}");
    }

    return getProduct;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<GetProduct?>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(child: Text("${snapshot.data!.id}"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
