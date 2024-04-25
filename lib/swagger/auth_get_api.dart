import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthGetApi extends StatefulWidget {
  const AuthGetApi({super.key});

  @override
  State<AuthGetApi> createState() => _AuthGetApiState();
}

class _AuthGetApiState extends State<AuthGetApi> {
  Future getAuth() async {
    var data;
    http.Response response = await http.get(
      Uri.parse('https://api.escuelajs.co/api/v1/auth/profile'),
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
        children: [
          FutureBuilder(
            future: getAuth(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // print(snapshot.data);
                return Column(
                  children: [
                    Center(
                      child: Text(snapshot.data['message']),
                    )
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
