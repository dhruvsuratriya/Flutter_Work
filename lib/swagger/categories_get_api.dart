import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoriesGetApi extends StatefulWidget {
  const CategoriesGetApi({super.key});

  @override
  State<CategoriesGetApi> createState() => _CategoriesGetApiState();
}

class _CategoriesGetApiState extends State<CategoriesGetApi> {
  Future getData() async {
    var data;
    http.Response response = await http.get(
      Uri.parse('https://api.escuelajs.co/api/v1/categories?limit=5'),
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // print(snapshot.data);
                    return Column(
                      children: List.generate(
                        snapshot.data.length,
                        (index) => Center(
                          child: Column(
                            children: [
                              Text(
                                snapshot.data[index]['name'].toString(),
                              ),
                              Image.network(
                                snapshot.data[index]['image'],
                                scale: 2,
                              )
                            ],
                          ),
                        ),
                      ),
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
      ),
    );
  }
}
