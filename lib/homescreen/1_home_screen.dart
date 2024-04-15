import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:foodbites/providers/10_user_provider.dart';
import 'package:foodbites/providers/9_product_provider.dart';
import 'package:provider/provider.dart';

import '../productdetail/2_product_detail.dart';
import '../productdetail/3_produc_detail.dart';
import '../review/7_review_screen.dart';
import '../serch/5_serch.dart';
import 'drawer_side.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List subtitle = ['Fresh food', 'Fresh food', 'Fresh food', 'Fresh food'];
  ProductProvider? productProvider;

  @override
  void initState() {
    ProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.fatchAllCategories();
    productProvider.fatchFreshPopularData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();

    return Scaffold(
      backgroundColor: const Color(0xffF5F7F8),
      drawer: DrawerSide(userProvider: userProvider),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Home'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SerchScreen(
                      search: productProvider!.search,
                    ),
                  ));
            },
            icon: const Icon(
              Icons.search_rounded,
            ),
          ),
          InkResponse(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ReviewScreen(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 22.sp,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
              child: Container(
                height: 25.h,
                width: 92.w,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/pizza 1.jpg'),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    Container(
                      width: 92.w,
                      decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 75.w),
                            child: Container(
                              height: 6.h,
                              width: 17.w,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/Picsart_24-01-09_15-27-03-303.jpg')),
                                color: Colors.black,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(30),
                                    topLeft: Radius.circular(12)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 10.h,
                      left: 5.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '30 % OFF',
                            style: TextStyle(
                              color: Colors.green,
                              shadows: const [
                                Shadow(
                                  color: Colors.white,
                                  offset: Offset(2, 1),
                                  blurRadius: 2,
                                ),
                              ],
                              fontWeight: FontWeight.bold,
                              fontSize: 30.sp,
                            ),
                          ),
                          Text(
                            'On all Fast-Food',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              children: [
                Text(
                  'All Categories',
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 42.w,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SerchScreen(
                          search: productProvider!.getAllCategoriesList,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'View all',
                    style: TextStyle(
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 14.sp,
                )
              ],
            ),
          ),
          SizedBox(
            height: 1.5.h,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                productProvider!.getAllCategoriesList.length,
                (index) => InkResponse(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetail(
                          productName: productProvider!
                              .getAllCategoriesList[index].productName,
                          productImage: productProvider!
                              .getAllCategoriesList[index].productImage,
                          productPrice: productProvider!
                              .getAllCategoriesList[index].productPrice,
                          productId: productProvider!
                              .getAllCategoriesList[index].productId,
                          // subtitle: productProvider!
                          //     .getAllCategoriesList[index].subtitle,
                        ),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 23.h,
                        width: 35.w,
                        margin: EdgeInsets.symmetric(horizontal: 3.w),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xffF2E3DB),
                              Colors.white,
                              // Color(0xffDEECFF),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(14),
                          // color: Color(0xffF2E3DB),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 1.h,
                            ),
                            Container(
                              height: 10.h,
                              width: 27.w,
                              child: Image.asset(
                                productProvider!
                                    .getAllCategoriesList[index].productImage,
                                scale: 3,
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              productProvider!
                                  .getAllCategoriesList[index].productName,
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              subtitle[index],
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.grey.shade600),
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            // SingleItem(
                            //   productImage: '',
                            //   productName: '',
                            //   productPrice: 2,
                            //   productId: '',
                            // )
                            // SingleItem(),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 2.8.w,
                        child: Container(
                          height: 3.h,
                          width: 16.w,
                          decoration: const BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16)),
                          ),
                          child: Center(
                            child: Text(
                              "₹${productProvider!.getAllCategoriesList[index].productPrice.toString()}",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              children: [
                Text(
                  'Popular',
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 56.2.w,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SerchScreen(
                          search: productProvider!.getFreshPopularDataList,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'View all',
                    style: TextStyle(
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 14.sp,
                )
              ],
            ),
          ),
          SizedBox(
            height: 1.5.h,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                productProvider!.freshPopularProduct.length,
                (index) => InkResponse(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PopularDetail(
                          productName: productProvider!
                              .getFreshPopularDataList[index].productName,
                          productImage: productProvider!
                              .getFreshPopularDataList[index].productImage,
                          productPrice: productProvider!
                              .getFreshPopularDataList[index].productPrice,
                          productId: productProvider!
                              .getFreshPopularDataList[index].productId,
                        ),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 25.h,
                        width: 35.w,
                        margin: EdgeInsets.symmetric(horizontal: 3.w),
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xffF2E3DB),
                              Colors.white,
                              // Color(0xffDEECFF),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              height: 11.h,
                              width: 36.w,
                              child: Image.asset(
                                productProvider!
                                    .getFreshPopularDataList[index].productImage
                                    .toString(),
                                scale: 2,
                                // fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              productProvider!
                                  .getFreshPopularDataList[index].productName,
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              subtitle[index],
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.grey.shade600),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            // CountScreen(
                            //   productName: 'Ds',
                            //   productImage: productImage,
                            //   productId: productName,
                            //   productPrice: productPrice,
                            // ),
                            // CountScreen(),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 2.8.w,
                        child: Container(
                          height: 3.h,
                          width: 16.w,
                          decoration: const BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16)),
                          ),
                          child: Center(
                              child: Text(
                            "₹${productProvider!.getFreshPopularDataList[index].productPrice.toString()}",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
