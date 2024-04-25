import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Company extends StatefulWidget {
  const Company({
    super.key,
    this.company,
    this.name,
  });
  final company;
  final name;

  @override
  State<Company> createState() => _CompanyState();
}

class _CompanyState extends State<Company> {
  Future getData() async {
    var data;
    http.Response response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/users/1'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
    } else {
      print('STATUS ${response.statusCode}');
    }
    return data!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
              child: Container(
            height: 100,
            width: 300,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 0),
                      blurRadius: 2,
                      spreadRadius: 2)
                ]),
            child: Center(
              child: Text(
                "Bs:${widget.company.toString()}",
                style: TextStyle(fontSize: 20),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
