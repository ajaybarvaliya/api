import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'H_Categories.dart';
import 'H_CategoriesWiseProduct.dart';
import 'H_Productdetails.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int change = 0;
  int? change1;

  ///categories

  var data;
  Future getcategories() async {
    http.Response responce = await http.get(
      Uri.parse("https://dummyjson.com/products/categories"),
    );

    if (responce.statusCode == 200) {
      data = jsonDecode(responce.body);
      print("RESPONCE ${responce.body}");
    } else {
      print("RESPONSE ${responce.statusCode}");
    }

    return data;
  }

  /// products
  var datas;
  Future getproduct() async {
    http.Response responce = await http.get(
      change1 == null
          ? Uri.parse("https://dummyjson.com/products")
          : Uri.parse(
              "https://dummyjson.com/products/category/${data[change1]}"),
    );

    if (responce.statusCode == 200) {
      datas = jsonDecode(responce.body);
      print("RESPONCE ${responce.body}");
    } else {
      print("RESPONSE ${responce.statusCode}");
    }

    return datas;
  }

  /// search
  var search;
  Future getSearch() async {
    http.Response responce = await http.get(
      Uri.parse("https://dummyjson.com/products/search?q=Laptop"),
    );

    if (responce.statusCode == 200) {
      search = jsonDecode(responce.body);
      print("RESPONCE ${responce.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),

            // Center(
            //   child: TextField(
            //     decoration: InputDecoration(
            //       contentPadding: EdgeInsets.symmetric(vertical: 3),
            //       hintText: "search",
            //       suffixIcon: Icon(Icons.search),
            //       constraints: BoxConstraints(maxWidth: 350, maxHeight: 50),
            //       border: OutlineInputBorder(
            //         borderSide: BorderSide(
            //           color: Colors.black,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Categories(allcategories: data),
                        ),
                      );
                    },
                    child: Text(
                      "See all",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: FutureBuilder(
                future: getcategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Container(
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {});
                              change = index;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoriesWiseProduct(
                                    categoriesproduct: snapshot.data[index],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 60,
                              width: 100,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: change == index
                                    ? Colors.grey
                                    : Colors.brown,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "${snapshot.data[index]}",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: FutureBuilder(
                future: getcategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Container(
                      height: 30,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              change1 = index;
                              setState(() {});
                            },
                            child: Container(
                              height: 20,
                              width: 100,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: change1 == index
                                    ? Colors.brown
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "${snapshot.data[index]}",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                "Products",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
            ),
            FutureBuilder(
              future: getproduct(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Expanded(
                    child: GridView.builder(
                      itemCount: snapshot.data["products"].length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.65),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Productsdetail(
                                  id: snapshot.data['products'][index]['id'],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 300,
                            width: 400,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 400,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          snapshot.data["products"][index]
                                              ["thumbnail"]),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    "Id :${snapshot.data["products"][index]["id"]}"),
                                Text(
                                    "Title :${snapshot.data["products"][index]["title"]}"),
                                Text(
                                    "Price :${snapshot.data["products"][index]["price"]}"),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
