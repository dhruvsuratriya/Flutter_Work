import 'dart:convert';

import 'package:api_task/ApiServices/Repo/get_products_repo.dart';
import 'package:api_task/ApiServices/api_routes.dart';
import 'package:api_task/Model/Response/products_response_model.dart';
import 'package:api_task/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'category.dart';
import 'category_productwise.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future getData() async {
    var data;
    try {
      http.Response response =
          await http.get(Uri.parse(ApiRoutes.getCategories));

      if (response.statusCode == 200) {
        data = jsonDecode(response.body);

        print('SUCCESS ${data[0]}');
      } else {
        print('STATUS ${response.statusCode}');
      }
    } catch (e) {
      print('ERROR $e');
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
            future: getData(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Center(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Serch',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          constraints:
                              BoxConstraints.expand(width: 320, height: 55),
                          prefixIcon: Icon(Icons.search_rounded),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Category',
                            style: TextStyle(fontSize: 20),
                          ),
                          Spacer(),
                          InkResponse(
                            onTap: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Category(
                                        id: snapshot.data,
                                      ),
                                    ));
                              });
                            },
                            child: Text(
                              'See all',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: List.generate(
                            4,
                            (index) => InkResponse(
                                  onTap: () {
                                    setState(() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CategoryProductWise(
                                                    category:
                                                        snapshot.data[index]),
                                          ));
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 80,
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Center(
                                        child: Text(
                                      "${snapshot.data[index]}",
                                      style: TextStyle(fontSize: 16),
                                    )),
                                  ),
                                )),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: const CircularProgressIndicator());
              } else {
                return Center(child: Text('ERROR'));
              }
            },
          ),
          FutureBuilder<ProductsResponseModel>(
            future: GetProductsRepo.getProductsRepo(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        'Products',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 2,
                            childAspectRatio: 1.12),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              InkResponse(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductDetail(
                                            productdetails: snapshot
                                                .data!.products[index].id),
                                      ));
                                },
                                child: Container(
                                  height: 150,
                                  width: 160,
                                  color: Colors.grey,
                                  child: Image.network(
                                    snapshot.data!.products[index].thumbnail,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: const CircularProgressIndicator());
              } else {
                return Center(child: Text('ERROR'));
              }
            },
          ),
        ],
      ),
    );
  }
}
