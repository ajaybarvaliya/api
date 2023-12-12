import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  var search;
  bool loading = false;

  Future getSearch(searchController) async {
    setState(() {
      loading = true;
    });
    http.Response response = await http.get(
        Uri.parse("https://dummyjson.com/products/search?q=$searchController"));

    if (response.statusCode == 200) {
      search = jsonDecode(response.body);
      print("RESPONCE ${response.body}");
    } else {
      print("RESPONSE ${response.statusCode}");
    }
    setState(() {
      loading = false;
    });
    return search;
  }

  @override
  void initState() {
    getSearch("");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "search",
                        suffixIcon: InkWell(
                          onTap: () {
                            getSearch(searchController.text);
                          },
                          child: Icon(Icons.search),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    searchController == ""
                        ? Text("no data found")
                        : search["products"].length == 0
                            ? Text("No data found")
                            : Expanded(
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: search["products"].length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 0.8,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Container(
                                          height: 100,
                                          child: Image.network(
                                              "${search["products"][index]["images"][0]}"),
                                        ),
                                        Text(
                                            "${search["products"][index]["id"]}")
                                      ],
                                    );
                                  },
                                ),
                              )
                  ],
                ),
              ),
      ),
    );
  }
}
