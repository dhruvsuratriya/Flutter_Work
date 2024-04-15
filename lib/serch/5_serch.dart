import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../model/8_product_model.dart';
import '../widget/6_single_item.dart';

class SerchScreen extends StatefulWidget {
  const SerchScreen({super.key, required this.search});

  final List<ProductModel> search;

  @override
  State<SerchScreen> createState() => _SerchScreenState();
}

class _SerchScreenState extends State<SerchScreen> {
  String query = "";
  searchItem(String query) {
    List<ProductModel> searchFood = widget.search.where((element) {
      return element.productName.toLowerCase().contains(query);
    }).toList();
    return searchFood;
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> _searchItem = searchItem(query);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF5F7F8),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Search"),
          actions: [
            Container(),
          ],
        ),
        body: ListView(
          children: [
            const ListTile(
              title: Text("Items"),
            ),
            Container(
              height: 9.h,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Search your food",
                  suffixIcon: Icon(Icons.search_rounded, color: Colors.black),
                ),
              ),
            ),
            Column(
              children: _searchItem.map((data) {
                return SingleItem(
                  isBool: false,
                  productImage: data.productImage,
                  productName: data.productName,
                  productPrice: data.productPrice,
                  productId: data.productId,
                );
              }).toList(),
            )
            // SingleItem(isBool: false)
          ],
        ),
      ),
    );
  }
}
