import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';

import '../providers/14_wish_list_provider.dart';
import '../review/7_review_screen.dart';
import '../widget/11_count.dart';

enum SinginCharacter { fill, outline }

class PopularDetail extends StatefulWidget {
  const PopularDetail({
    super.key,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productId,
  });
  final String productName;
  final String productImage;
  final int productPrice;
  final String productId;
  @override
  State<PopularDetail> createState() => _PopularDetailState();
}

class _PopularDetailState extends State<PopularDetail> {
  SinginCharacter _character = SinginCharacter.fill;

  Widget BottomNavigatorBar({
    required Color iconColor,
    required Color backgroundColor,
    required Color color,
    required String title,
    required IconData iconData,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        color: backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 26,
              color: iconColor,
            ),
            SizedBox(
              width: 1.w,
            ),
            Text(
              title,
              style: TextStyle(color: color),
            )
          ],
        ),
      ),
    );
  }

  bool wishListBool = false;
  getWishtListBool() {
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourWishList")
        .doc(widget.productId)
        .get()
        .then((value) => {
              if (value.exists)
                {
                  setState(
                    () {
                      wishListBool = value.get("wishList");
                    },
                  )
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    WishListProvider wishListProvider = Provider.of(context);
    getWishtListBool();
    return Scaffold(
      // bottomNavigationBar: Row(
      //   children: [
      //     Container(
      //       child: BottomNavigatorBar(
      //         iconColor: Colors.white,
      //         backgroundColor: Colors.black,
      //         color: Colors.white,
      //         title: "Add To WishList",
      //         iconData: Icons.favorite_border,
      //       ),
      //     ),
      //     BottomNavigatorBar(
      //       iconColor: Colors.white,
      //       backgroundColor: Colors.grey,
      //       color: Colors.white,
      //       title: "Go To Cart",
      //       iconData: Icons.shopping_bag_outlined,
      //     ),
      //   ],
      // ),
      backgroundColor: Color(0xffF5F7F8),
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Product Detail',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    height: 34.h,
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    child: Image.asset(widget.productImage),
                  ),
                  ListTile(
                    title: Text(
                      widget.productName,
                      style: TextStyle(
                          fontSize: 24.sp, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "₹${widget.productPrice.toString()}",
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Radio(
                          activeColor: Colors.green,
                          value: SinginCharacter.fill,
                          groupValue: _character,
                          onChanged: (value) {
                            setState(() {
                              _character = value!;
                            });
                          },
                        ),
                        Text(
                          "₹${widget.productPrice.toString()}",
                          style: TextStyle(fontSize: 18.sp),
                        ),
                        CountScreen(
                          productId: widget.productId,
                          productImage: widget.productImage,
                          productName: widget.productName,
                          productPrice: widget.productPrice,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              color: Colors.grey.shade300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About The Food',
                    style:
                        TextStyle(fontSize: 19.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    'Food is any substance consumed by an organism for nutritional support. Food is usually of plant, animal, or fungal origin and contains essential nutrients such as carbohydrates, fats, proteins, vitamins, or minerals.',
                    style:
                        TextStyle(fontSize: 17.sp, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              InkResponse(
                child: Container(
                  height: 6.h,
                  width: 50.w,
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      wishListBool == false
                          ? Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.favorite,
                              color: Colors.white,
                            ),
                      Text(
                        "  Add To WishList",
                        style: TextStyle(color: Colors.white, fontSize: 15.sp),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  setState(() {
                    wishListBool = !wishListBool;
                  });
                  if (wishListBool == true) {
                    wishListProvider.addWishListData(
                      wishListId: widget.productId,
                      wishListImage: widget.productImage,
                      wishListName: widget.productName,
                      wishListPrice: widget.productPrice,
                      wishListQuantity: 2,
                    );
                  } else {
                    wishListProvider.deleteWishList(widget.productId);
                  }
                },
              ),
              InkResponse(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReviewScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 6.h,
                  width: 50.w,
                  color: Colors.black54,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.white,
                      ),
                      Text(
                        "  Go To Cart",
                        style: TextStyle(color: Colors.white, fontSize: 15.sp),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
