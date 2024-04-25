import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostApi extends StatefulWidget {
  const PostApi({super.key});

  @override
  State<PostApi> createState() => _PostApiState();
}

class _PostApiState extends State<PostApi> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController descripcontroller = TextEditingController();
  TextEditingController categorycontroller = TextEditingController();
  TextEditingController imagescontroller = TextEditingController();

  var data;
  bool loading = false;
  bool error = false;

  Future addProduct(
    String title,
    int price,
    String description,
    int categoryId,
    images,
  ) async {
    var body = {
      "title": "${title}",
      "price": "${price}",
      "description": "${description}",
      "categoryId": "${images}",
      "images": [
        "https://images.unsplash.com/photo-1682686581854-5e71f58e7e3f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8&auto=format&fit=crop&w=600&q=60"
      ]
    };
    setState(
      () {
        loading = true;
      },
    );

    var headers = {'Content-Type': 'application/json'};

    http.Response response = await http.post(
      Uri.parse('https://api.escuelajs.co/api/v1/products'),
      headers: headers,
      body: jsonEncode({
        "title": "${title}",
        "price": "${price}",
        "description": "${description}",
        "categoryId": "${categoryId}",
        "images": [
          "https://images.unsplash.com/photo-1682686581854-5e71f58e7e3f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8&auto=format&fit=crop&w=600&q=60"
        ]
      }),
    );
    if (response.statusCode == 200) {
      print(response.body);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Successfully Add'),
        ),
      );
      setState(
        () {
          loading = false;
        },
      );
    } else {
      print(response.body);
      print(response.statusCode);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Can not Add'),
        ),
      );
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(30),
              child: SafeArea(
                child: Column(
                  children: [
                    TextField(
                      controller: titlecontroller,
                      decoration: InputDecoration(
                          hintText: 'Title',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14)),
                          constraints:
                              BoxConstraints.expand(width: 300, height: 50)),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextField(
                      controller: pricecontroller,
                      decoration: InputDecoration(
                          hintText: 'Price',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14)),
                          constraints:
                              BoxConstraints.expand(width: 300, height: 50)),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextField(
                      controller: descripcontroller,
                      decoration: InputDecoration(
                          hintText: 'Descrip',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14)),
                          constraints:
                              BoxConstraints.expand(width: 300, height: 50)),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextField(
                      controller: categorycontroller,
                      decoration: InputDecoration(
                          hintText: 'CategoryId',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14)),
                          constraints:
                              BoxConstraints.expand(width: 300, height: 50)),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    // TextField(
                    //   controller: imagescontroller,
                    //   decoration: InputDecoration(
                    //       hintText: 'Images',
                    //       border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(14)),
                    //       constraints:
                    //           BoxConstraints.expand(width: 300, height: 50)),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            addProduct(
                              titlecontroller.text,
                              int.parse("200"),
                              descripcontroller.text,
                              int.parse("1"),
                              imagescontroller.text,
                            );
                          });
                        },
                        child: Text("CLICK"))
                  ],
                ),
              ),
            ),
    );
  }
}
