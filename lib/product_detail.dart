import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key, this.productdetails});

  final productdetails;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  Future getData() async {
    var data;
    try {
      http.Response response = await http.get(
          Uri.parse('https://dummyjson.com/products/${widget.productdetails}'));

      if (response.statusCode == 200) {
        data = jsonDecode(response.body);

        print('SUCCESS ${data[0]}');
      } else {
        print('STATUS ${response.statusCode}');
      }
    } catch (e) {
      print('ERROR $e');
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: PageView.builder(
                        itemCount: snapshot.data['images'].length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: double.infinity,
                            color: Colors.black,
                            child: Image.network(
                              snapshot.data['images'][index],
                              fit: BoxFit.cover,
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Id : ${snapshot.data['id']}",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "Title : ${snapshot.data['title']}",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "Description : ${snapshot.data['description']}",
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                        Text(
                          "Price : ${snapshot.data['Price']}",
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                        Text(
                          "DiscountPercentage : ${snapshot.data['discountPercentage']}",
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                        Text(
                          "Rating : ${snapshot.data['rating']}",
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                        Text(
                          "Category : ${snapshot.data['category']}",
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: const CircularProgressIndicator());
            } else {
              return Center(child: Text('ERROR'));
            }
          },
        ),
      ),
    );
  }
}
