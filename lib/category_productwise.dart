import 'package:api_task/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Model/Response/products_response_model.dart';

class CategoryProductWise extends StatefulWidget {
  const CategoryProductWise({super.key, this.category});
  final category;

  @override
  State<CategoryProductWise> createState() => _CategoryProductWiseState();
}

class _CategoryProductWiseState extends State<CategoryProductWise> {
  Future<ProductsResponseModel> getDete() async {
    ProductsResponseModel? dete;
    try {
      http.Response response = await http.get(Uri.parse(
          'https://dummyjson.com/products/category/${widget.category}'));

      if (response.statusCode == 200) {
        dete = productsResponseModelFromJson(response.body);

        print('SUCCESS ${[1]}');
      } else {
        print('STATUS ${response.statusCode}');
      }
    } catch (e) {
      print('ERROR $e');
    }
    return dete!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            FutureBuilder(
              future: getDete(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 2,
                          childAspectRatio: 1.12),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            InkResponse(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetail(
                                        productdetails:
                                            snapshot.data?.products[index].id,
                                      ),
                                    ));
                              },
                              child: Container(
                                height: 150,
                                width: 160,
                                color: Colors.grey,
                                child: Image.network(
                                  snapshot.data!.products[index].thumbnail,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        );
                      });
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: const CircularProgressIndicator());
                } else {
                  return Center(child: Text('ERROR'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
