import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostApi1 extends StatefulWidget {
  const PostApi1({super.key});

  @override
  State<PostApi1> createState() => _PostApi1State();
}

class _PostApi1State extends State<PostApi1> {
  TextEditingController controller = TextEditingController();
  var date;
  bool loading = false;
  bool error = false;

  Future getserch(title) async {
    var body = {"title": "${title}"};
    setState(() {
      loading = true;
    });

    try {
      http.Response response = await http
          .post(Uri.parse('https://dummyjson.com/products/add'), body: body);
      if (response.statusCode == 200) {
        date = jsonDecode(response.body);
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("SUCCESSFULL"),
        ));
      } else {
        setState(() {
          loading = false;
          error = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14)),
                          constraints: const BoxConstraints.expand(
                              width: 300, height: 50)),
                    ),
                  ),
                  const SizedBox(
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
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
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
