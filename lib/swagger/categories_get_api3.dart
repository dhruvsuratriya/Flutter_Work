import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoriesGetApi3 extends StatefulWidget {
  const CategoriesGetApi3({super.key});

  @override
  State<CategoriesGetApi3> createState() => _CategoriesGetApi3State();
}

class _CategoriesGetApi3State extends State<CategoriesGetApi3> {
  Future getData() async {
    var data;
    http.Response response = await http.get(
      Uri.parse(
          'https://api.escuelajs.co/api/v1/categories/6/products?limit=10&offset=1'),
    );
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
    } else {
      print("STATUS : ${response.statusCode}");
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: List.generate(
                      snapshot.data.length,
                      (index) => Center(
                            child: Text(snapshot.data[index]['description']),
                          )),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
