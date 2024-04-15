import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:foodbites/model/8_product_model.dart';
import 'package:foodbites/providers/14_wish_list_provider.dart';
import 'package:provider/provider.dart';

import '../widget/6_single_item.dart';

class WishList extends StatefulWidget {
  late WishListProvider wishListProvider;
  // const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  late WishListProvider wishListProvider;
  @override
  Widget build(BuildContext context) {
    WishListProvider wishListProvider = Provider.of(context);
    wishListProvider = Provider.of(context);
    wishListProvider.getWishListData();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF5F7F8),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "WishList",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: wishListProvider.getWishList.length,
          itemBuilder: (context, index) {
            ProductModel data = wishListProvider.getWishList[index];
            return Column(
              children: [
                SingleItem(
                  isBool: true,
                  productImage: data.productImage,
                  productName: data.productName,
                  productPrice: data.productPrice,
                  productId: data.productId,
                  productQuantity: data.productQuantity,
                ),
                IconButton(
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('WishList Product'),
                      content:
                          const Text('Are you delete on wishList Product?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'No');
                          },
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            wishListProvider.deleteWishList(data.productId);
                            Navigator.pop(context);
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    ),
                  ),
                  icon: Icon(
                    Icons.delete_outline,
                    size: 24.sp,
                  ),
                ),
                Divider(
                  height: 1.h,
                  indent: 16,
                  endIndent: 18,
                  color: Colors.black,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
