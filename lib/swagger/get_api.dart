import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetApi extends StatefulWidget {
  const GetApi({super.key});

  @override
  State<GetApi> createState() => _GetApiState();
}

class _GetApiState extends State<GetApi> {
  Future getData() async {
    var data;
    http.Response response = await http.get(
      Uri.parse('https://api.escuelajs.co/api/v1/products?limit=10&offset=50'),
    );
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
    } else {
      print('STATUS ${response.statusCode}');
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
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    children: List.generate(
                      snapshot.data.length,
                      (index) => Center(
                        child: Text(snapshot.data[index]['title']),
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
    );
  }
}
