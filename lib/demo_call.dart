import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DemoCall extends StatefulWidget {
  const DemoCall({super.key});

  @override
  State<DemoCall> createState() => _DemoCallState();
}

class _DemoCallState extends State<DemoCall> {
  var dete;
  bool loading = false;
  bool error = false;

  Future getProducts() async {
    setState(() {
      loading = true;
    });

    try {
      http.Response response =
          await http.get(Uri.parse('https://dummyjson.com/products'));

      if (response.statusCode == 200) {
        dete = jsonDecode(response.body);
        setState(() {
          loading = false;
        });

        // print('SUCCESS ${dete[0]}');
      } else {
        setState(() {
          loading = false;
          error = true;
        });

        print('STATUS ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        loading = false;
        error = true;
      });
      print('ERROR $e');
    }
    return dete;
  }

  @override
  void initState() {
    getProducts();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: error
          ? const Center(
              child: Text('Error'),
            )
          : loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : dete == null
                  ? const Center(
                      child: Text('No Data'),
                    )
                  : Center(child: Text('DATA $dete')),
    );
  }
}
