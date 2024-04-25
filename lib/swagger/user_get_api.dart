import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserGetApi extends StatefulWidget {
  const UserGetApi({super.key});

  @override
  State<UserGetApi> createState() => _UserGetApiState();
}

class _UserGetApiState extends State<UserGetApi> {
  Future getData() async {
    var data;
    http.Response response = await http.get(
      Uri.parse('https://api.escuelajs.co/api/v1/users?limit=6'),
    );
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
    } else {
      print("STATUS ${response.statusCode}");
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
                    return Column(
                      children: List.generate(
                        snapshot.data.length,
                        (index) => Center(
                          child: Column(
                            children: [
                              Text(
                                snapshot.data[index]['email'],
                                style: TextStyle(fontSize: 16),
                              ),
                              Image.network(snapshot.data[index]['avatar'])
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
