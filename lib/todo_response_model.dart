import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Model/Response/todo_response.dart';

class TodoResponseModel extends StatefulWidget {
  const TodoResponseModel({super.key});

  @override
  State<TodoResponseModel> createState() => _TodoResponseModelState();
}

class _TodoResponseModelState extends State<TodoResponseModel> {
  Future<Todoresponse> getData() async {
    Todoresponse? data;
    http.Response response =
        await http.get(Uri.parse('https://dummyjson.com/todos'));
    if (response.statusCode == 200) {
      data = todoresponseFromJson(response.body);
    } else {
      print('STATUS ${response.statusCode}');
    }
    return data!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Todoresponse>(
        future: getData(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: List.generate(
                      10,
                      (index) => Center(
                            child: Container(
                              height: 50,
                              width: 260,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child:
                                    Text('${snapshot.data!.todos[index].todo}'),
                              ),
                            ),
                          )),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
