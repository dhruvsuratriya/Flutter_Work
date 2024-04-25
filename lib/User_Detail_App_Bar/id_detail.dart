import 'dart:convert';

import 'package:api_task/User_Detail_App_Bar/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class IdDetail extends StatefulWidget {
  const IdDetail({super.key});

  @override
  State<IdDetail> createState() => _IdDetailState();
}

class _IdDetailState extends State<IdDetail> {
  Future getid() async {
    var data;
    http.Response response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
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
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder(
              future: getid(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    children: List.generate(
                      snapshot.data.length,
                      (index) => Center(
                        child: InkResponse(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserDetail(
                                    personal: snapshot.data[index]['username'],
                                    email: snapshot.data[index]['email'],
                                    address: snapshot.data[index]['address']
                                        ['street'],
                                    city: snapshot.data[index]['address']
                                        ['city'],
                                    zipcode: snapshot.data[index]['address']
                                        ['zipcode'],
                                    company: snapshot.data[index]['company']
                                        ['bs'],
                                  ),
                                ));
                          },
                          child: Container(
                            height: 50,
                            width: 200,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                    child:
                                        Text('${snapshot.data[index]['id']}')),
                                Center(
                                  child:
                                      Text('${snapshot.data[index]['name']}'),
                                ),
                              ],
                            ),
                          ),
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
    );
  }
}
