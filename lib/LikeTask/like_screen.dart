import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({super.key, this.tap});
  final tap;

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  static GetStorage box = GetStorage();

  List? likedData;

  @override
  void initState() {
    likedData = jsonDecode(box.read('likedData'));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.72),
          itemCount: likedData?.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 170,
                          width: 170,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Image.network(
                            likedData?[index]['images'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text("Id : ${likedData?[index]['Id']}"),
                        Text("Name : ${likedData?[index]['Name']}"),
                        Text("Diractory : ${likedData?[index]['Diractory']}")
                      ],
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }
}
