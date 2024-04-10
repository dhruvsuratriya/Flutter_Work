import 'package:flutter/material.dart';

import 'category_productwise.dart';

class Category extends StatefulWidget {
  const Category({super.key, this.id});
  final id;

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              children: List.generate(
                  widget.id.length,
                  (index) => Center(
                        child: InkResponse(
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryProductWise(
                                      category: widget.id[index],
                                    ),
                                  ));
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 160,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(14)),
                            child: Center(
                                child: Text(
                              widget.id[index],
                              style: TextStyle(fontSize: 20),
                            )),
                          ),
                        ),
                      ))),
        ),
      ),
    );
  }
}
