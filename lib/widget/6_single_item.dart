import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';

import '../providers/13_review_cart_provider.dart';
import '11_count.dart';

class SingleItem extends StatefulWidget {
  SingleItem({
    super.key,
    required this.isBool,
    this.productImage,
    this.productName,
    this.productPrice,
    this.productId,
    this.productQuantity,
  });

  bool isBool = false;
  final productImage;
  final productName;
  final productId;
  final dynamic productPrice;
  final productQuantity;

  @override
  State<SingleItem> createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  // final bool wishList = false;
  // late int count;
  // getCount() {
  //   setState(() {
  //     count = widget.productQuantity;
  //   });
  // }

  late ReviewCartProvider reviewCartProvider;

  @override
  Widget build(BuildContext context) {
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    reviewCartProvider.getReviewCartData();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 11.h,
                  child: Center(
                    child: Image.asset(widget.productImage),
                  ),
                ),
              ),
              SizedBox(
                width: 6.w,
              ),
              Expanded(
                child: Container(
                  height: 14.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.productName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.sp),
                          ),
                          SizedBox(
                            height: 0.3.h,
                          ),
                          Text(
                            'Fresh Fast-Food',
                            style:
                                TextStyle(fontSize: 15.sp, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            '₹${widget.productPrice}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
        // isBool == false
        //     ? Container()
        //     : Divider(
        //         height: 1,
        //         color: Colors.black,
        //       )
      ],
    );
  }
}
