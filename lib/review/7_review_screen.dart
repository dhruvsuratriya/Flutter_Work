import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:foodbites/check_out/delivery_details.dart';
import 'package:provider/provider.dart';

import '../model/12_review_cart_model.dart';
import '../providers/13_review_cart_provider.dart';
import '../widget/6_single_item.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({
    super.key,
    // this.onDelete,
  });

  // final onDelete;
  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF5F7F8),
        bottomNavigationBar: ListTile(
          title: Text(
            "Total Amount",
            style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey,
                fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "₹${reviewCartProvider.getTotalPrice()}",
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          trailing: Container(
            height: 5.h,
            width: 16.h,
            child: MaterialButton(
              onPressed: () {
                if (reviewCartProvider.getReviewCartDataList.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("No Cart Data Found"),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeliveryDetails(),
                    ),
                  );
                }
              },
              child: Text(
                'Order Now',
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Review Cart",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: reviewCartProvider.getReviewCartDataList.length,
          itemBuilder: (context, index) {
            ReviewCartModel data =
                reviewCartProvider.getReviewCartDataList[index];
            return Column(
              children: [
                SingleItem(
                  isBool: false,
                  productImage: data.cartImage,
                  productName: data.cartName,
                  productPrice: data.cartPrice,
                  productId: data.cartId,
                  productQuantity: data.cartQuantity,
                ),
                IconButton(
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Cart Food'),
                      content: const Text('Are you delete your food?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'No');
                          },
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            reviewCartProvider
                                .reviewCartDataDelete(data.cartId);
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
