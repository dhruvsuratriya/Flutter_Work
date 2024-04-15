import 'package:flutter/material.dart';

class FutureDemo extends StatefulWidget {
  const FutureDemo({super.key});

  @override
  State<FutureDemo> createState() => _FutureDemoState();
}

class _FutureDemoState extends State<FutureDemo> {
  List<Map<String, dynamic>> detail = [
    {"name": "Dhruv", "lastname": "Sutariya", "age": 20},
    {"name": "Kishan", "lastname": "Ramoliya", "age": 20},
    {"name": "Niraj", "lastname": "Savliya", "age": 20},
  ];
  Future<List<Map<String, dynamic>>> demo() async {
    print("Hello");

    await Future.delayed(Duration(seconds: 2));
    print("Hello Codeline");

    return detail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: demo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => Text("${snapshot.data?[index]['name']}"),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
