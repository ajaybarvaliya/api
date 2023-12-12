import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as htpp;

class PageViewer extends StatefulWidget {
  const PageViewer({super.key});

  @override
  State<PageViewer> createState() => _PageViewerState();
}

class _PageViewerState extends State<PageViewer> {
  // TextEditingController limit = TextEditingController();
  // TextEditingController offset = TextEditingController();
  ScrollController scroll = ScrollController();
  bool loading = false;
  List data = [];
  // List<String> data1 = [];
  int limit1 = 5;
  int offset1 = 1;

  Future<void> getData(int i, int l) async {
    setState(() {
      loading = true;
    });

    htpp.Response response = await htpp.get(
      Uri.parse(
          'https://api.escuelajs.co/api/v1/products?limit=$limit1&offset=$offset1'),
    );
    if (response.statusCode == 200) {
      print('OFFSET $offset1');
      if (offset1 == 1) {
        data = jsonDecode(response.body);
        offset1++;
        setState(() {});
      } else {
        offset1++;
        setState(() {});
        var d1 = jsonDecode(response.body);
        data.addAll(d1);
      }

      print("${response.body}");
    } else {
      print("${response.statusCode}");
    }

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData(5, 0);
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        getData(5, 0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: offset1 == 1 && loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      getData(10, 0);
                    },
                    child: const Text("Get Data"),
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: scroll,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.all(10),
                          height: 280,
                          width: 250,
                          color: Colors.grey.shade300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        NetworkImage(data[index]['images'][0]),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(7),
                                child: Text(
                                  "Id    ${data[index]['id']}",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(7),
                                child: Text(
                                  "${data[index]['title']}",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(7),
                                child: Text(
                                  "Price :- ${data[index]['price']}",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(7),
                                child: Text(
                                  "description :- ${data[index]['description']}",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  loading ? CircularProgressIndicator() : SizedBox(),
                ],
              ),
      ),
    );
  }
}
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class Limit extends StatefulWidget {
//   const Limit({super.key});
//
//   @override
//   State<Limit> createState() => _LimitState();
// }
//
// class _LimitState extends State<Limit> {
//   TextEditingController limitController = TextEditingController();
//   TextEditingController offsetController = TextEditingController();
//   ScrollController scroll = ScrollController();
//
//   List data = [];
//   bool loading = false;
//   int limit = 6;
//   int offset = 0;
//
//   Future getData() async {
//     setState(() {
//       loading = true;
//     });
//     http.Response response = await http.get(
//       Uri.parse(
//           "https://api.escuelajs.co/api/v1/products?limit=$limit&offset=$offset"),
//     );
//
//     if (response.statusCode == 200) {
//       if (offset == 1) {
//         data = jsonDecode(response.body);
//         offset++;
//         setState(() {});
//       } else {
//         offset++;
//         setState(() {});
//         var d1 = jsonDecode(response.body);
//         data.addAll(d1);
//       }
//       data = jsonDecode(response.body);
//       print("RESPONCE ${response.body}");
//     } else {
//       print("RESPONSE ${response.statusCode}");
//     }
//     setState(() {
//       loading = false;
//     });
//   }
//
//   @override
//   void initState() {
//     getData();
//     scroll.addListener(() {
//       if (scroll.position.pixels == scroll.position.maxScrollExtent) {
//         getData();
//       }
//     });
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: offset == 1 && loading
//               ? Center(
//                   child: CircularProgressIndicator(),
//                 )
//               : Column(
//                   children: [
//                     TextField(
//                       controller: limitController,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                           hintText: "Limit", border: OutlineInputBorder()),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     TextField(
//                       controller: offsetController,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                           hintText: "Offset", border: OutlineInputBorder()),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         getData();
//                         setState(() {});
//                       },
//                       child: Text("press"),
//                     ),
//                     Expanded(
//                       child: GridView.builder(
//                         controller: scroll,
//                         itemCount: data.length,
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             mainAxisSpacing: 10,
//                             childAspectRatio: 0.7,
//                             crossAxisSpacing: 10),
//                         itemBuilder: (context, index) {
//                           return Container(
//                             decoration: BoxDecoration(
//                               color: Colors.cyan.shade50,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Column(
//                               children: [
//                                 Container(
//                                   width: double.infinity,
//                                   height: 100,
//                                   child: Image.network(
//                                     "${data[index]["images"][0]}",
//                                   ),
//                                 ),
//                                 Text("${data[index]["id"]}"),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     loading ? CircularProgressIndicator() : SizedBox(),
//                   ],
//                 ),
//         ),
//       ),
//     );
//   }
// }
