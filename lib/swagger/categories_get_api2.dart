import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoriesGetApi2 extends StatefulWidget {
  const CategoriesGetApi2({super.key});

  @override
  State<CategoriesGetApi2> createState() => _CategoriesGetApi2State();
}

class _CategoriesGetApi2State extends State<CategoriesGetApi2> {
  Future getData() async {
    var data;
    http.Response response = await http.get(
      Uri.parse('https://api.escuelajs.co/api/v1/categories?limit=1'),
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
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // print(snapshot.data);
                  return Column(
                    children: [
                      SizedBox(
                        height: 700,
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Center(
                              child: Column(
                                children: [
                                  Text(
                                    snapshot.data[index]['name'],
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Image.network(
                                    snapshot.data[index]['image'],
                                    scale: 10,
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
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
      ),
    );
  }
}
