import 'dart:async';

import 'package:flutter/material.dart';

class StreamBUilderDemo extends StatefulWidget {
  const StreamBUilderDemo({super.key});

  @override
  State<StreamBUilderDemo> createState() => _StreamBUilderDemoState();
}

class _StreamBUilderDemoState extends State<StreamBUilderDemo> {
  int count = 0;

  StreamController counter = StreamController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          count++;
          counter.sink.add(count);
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: counter.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(child: Text("${count}"));
          } else {
            return Center(
              child: Text("No Data"),
            );
          }
        },
      ),
    );
  }
}
