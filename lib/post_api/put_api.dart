import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PutApi extends StatefulWidget {
  const PutApi({super.key});

  @override
  State<PutApi> createState() => _PutApiState();
}

class _PutApiState extends State<PutApi> {
  TextEditingController controller = TextEditingController();
  var date;
  bool loading = false;
  bool error = false;

  Future getserch(title) async {
    var body = {"title": controller.text};
    setState(() {
      loading = true;
    });

    try {
      http.Response response = await http
          .put(Uri.parse('https://dummyjson.com/products/1'), body: body);
      if (response.statusCode == 200) {
        date = jsonDecode(response.body);
        setState(() {
          loading = false;
        });
        print("${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("SUCCESSFULL"),
        ));
      } else {
        setState(() {
          loading = false;
          error = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Not Right"),
        ));
        print('STATUS ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        loading = false;
        error = true;
      });
      print('ERROR $e');
    }

    return date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                  ),
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
                    height: 30,
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
