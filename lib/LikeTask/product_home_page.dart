import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'like_screen.dart';

class ProductHomePage extends StatefulWidget {
  const ProductHomePage({super.key});

  @override
  State<ProductHomePage> createState() => _ProductHomePageState();
}

List<Map<String, dynamic>> data = [
  {
    "images":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_DN7V9_OhS9j5CPTGHHy6kR72OZp2NJYMlA&usqp=CAU",
    "Id": "1",
    "Name": "Camera",
    "Diractory": "Pentax"
  },
  {
    "images":
        "https://idestiny.in/wp-content/uploads/2022/09/Apple_Watch_SE_LTE_40mm_Starlight_Aluminum_Starlight_Sport_Band_PDP_Images_Position-1__en-IN.jpg",
    "Id": "2",
    "Name": "Watch",
    "Diractory": "Apple"
  },
  {
    "images":
        "https://assets.adidas.com/images/w_600,f_auto,q_auto/f9d52817f7524d3fb442af3b01717dfa_9366/Runfalcon_3.0_Shoes_Black_HQ3790_01_standard.jpg",
    "Id": "3",
    "Name": "Shoes",
    "Diractory": "adidas"
  },
  {
    "images":
        "https://5.imimg.com/data5/SELLER/Default/2023/6/313157695/EE/UA/ZD/112338736/ba1.jpg",
    "Id": "4",
    "Name": "Headphone",
    "Diractory": "Boat"
  },
  {
    "images":
        "https://www.tiendaamiga.com.bo/media/catalog/product/cache/deb88dadd509903c96aaa309d3e790dc/i/p/iphone-14-pro-finish-select-202209-6-7inch-spaceblack.jpg",
    "Id": "5",
    "Name": "Mobeil",
    "Diractory": "Apple 14 pro max"
  },
  {
    "images":
        "https://static.thcdn.com/images/small/original/widgets/95-us/41/original-cleansers-072235-063441.png",
    "Id": "6",
    "Name": "Skincare",
    "Diractory": "Dr.Loretta"
  }
];

List<Map<String, dynamic>> liked = [];

class _ProductHomePageState extends State<ProductHomePage> {
  static GetStorage box = GetStorage();
  bool like = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.arrow_forward,
          size: 30,
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LikeScreen(),
              ));
        },
      ),
      body: Column(
        children: [
          GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.72),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 170,
                          width: 170,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: Image.network(
                            data[index]['images'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          left: 134,
                          top: 6,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                maxRadius: 17,
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {});
                                      if (liked.contains(data[index])) {
                                        liked.remove(data[index]);
                                      } else {
                                        liked.add(data[index]);
                                      }

                                      box.write("likedData", jsonEncode(liked));

                                      setState(() {});
                                    },
                                    icon: liked.contains(data[index])
                                        ? const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                            size: 20,
                                          )
                                        : const Icon(
                                            Icons.favorite_border,
                                            color: Colors.black,
                                            size: 20,
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Id : ${data[index]['Id']}"),
                    Text("Name : ${data[index]['Name']}"),
                    Text("Diractory : ${data[index]['Diractory']}")
                  ],
                );
              }),
        ],
      ),
    );
  }
}
