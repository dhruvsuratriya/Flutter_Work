import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PutApi02 extends StatefulWidget {
  const PutApi02({super.key});

  @override
  State<PutApi02> createState() => _PutApi02State();
}

class _PutApi02State extends State<PutApi02> {
  TextEditingController controller = TextEditingController();
  bool loding = false;
  bool error = false;
  var data;
  Future getserch(title) async {
    var body = {"title": controller.text};
    setState(() {
      loding = true;
    });

    try {
      http.Response response = await http.put(
          Uri.parse('https://api.escuelajs.co/api/v1/products/10'),
          body: body);
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        setState(() {
          loding = false;
        });
        print("${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("SUCCESFULL"),
          ),
        );
      } else {
        setState(() {
          loding = false;
          error = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("NOT RIGHT"),
          ),
        );
        print('STATUS : ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        loding = false;
        error = true;
      });
      print('ERROR $e');
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: loding
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                          hintText: 'Serch',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14)),
                          constraints:
                              BoxConstraints.expand(width: 300, height: 50)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkResponse(
                    onTap: () {
                      setState(() {
                        getserch(controller.text);
                      });
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                          child: Text(
                        'UPLODE',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )),
                    ),
                  ),
                ],
              ));
  }
}
