import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserGet2Api extends StatefulWidget {
  const UserGet2Api({super.key});

  @override
  State<UserGet2Api> createState() => _UserGet2ApiState();
}

class _UserGet2ApiState extends State<UserGet2Api> {
  Future getData() async {
    var data;
    http.Response response = await http.get(
      Uri.parse('https://api.escuelajs.co/api/v1/users/10'),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // print(snapshot.data);
                return Column(
                  children: [
                    Center(
                      child: Text(
                        snapshot.data['email'],
                      ),
                    ),
                    Text(
                      snapshot.data['password'],
                    ),
                    Text(
                      snapshot.data['name'],
                    ),
                    Text(
                      snapshot.data['role'],
                    ),
                  ],
                );
              } else {
                return const Center(
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
