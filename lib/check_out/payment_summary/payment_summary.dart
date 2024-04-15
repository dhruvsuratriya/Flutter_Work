import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:foodbites/check_out/payment_summary/order_item.dart';
import 'package:foodbites/check_out/payment_summary/upi_payment_screen.dart';
import 'package:foodbites/providers/13_review_cart_provider.dart';
import 'package:provider/provider.dart';

import '../single_delivery_item.dart';

class PaymentSummary extends StatefulWidget {
  const PaymentSummary({
    super.key,
    this.deliverAddressList,
  });

  final deliverAddressList;
  @override
  State<PaymentSummary> createState() => _PaymentSummaryState();
}

enum AddressTypes {
  Home,
  OnlinePayment,
  Other,
}

class _PaymentSummaryState extends State<PaymentSummary> {
  var myType = AddressTypes.Home;
  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    double discount = 30;
    double? discountValue;
    double shippingCharge = 3.7;
    double? total;
    double totalPrice = reviewCartProvider.getTotalPrice();
    if (totalPrice >= 0) {
      discountValue = (totalPrice * discount) / 100;
      total = totalPrice - discountValue;
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Check Out"),
          backgroundColor: Colors.black,
        ),
        bottomNavigationBar: ListTile(
          title: Text(
            "Total Amount",
            style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey,
                fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "₹${total! + 5 ?? totalPrice}",
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
                myType == AddressTypes.OnlinePayment
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpiPaymentScreen(total: total),
                        ),
                      )
                    : Container();
              },
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Place Order',
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SingleDeliveryItem(
                      title:
                          "${widget.deliverAddressList.firstName} ${widget.deliverAddressList.lastName}",
                      address:
                          "${widget.deliverAddressList.society},${widget.deliverAddressList.area},${widget.deliverAddressList.city}\n${widget.deliverAddressList.pincode}",
                      number: "Mob no : ${widget.deliverAddressList.mobilNo}",
                      addressType: widget.deliverAddressList.addressType ==
                              "AddressType.Home"
                          ? "Other"
                          : widget.deliverAddressList.addressType ==
                                  "AddressType.Other"
                              ? "Other"
                              : "Work"),
                  // const Divider(
                  //   thickness: 1,
                  // ),
                  ExpansionTile(
                    title: Text(
                      "Order Items ${reviewCartProvider.getReviewCartDataList.length}",
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    children: reviewCartProvider.getReviewCartDataList.map((e) {
                      return OrderItem(
                        e: e,
                      );
                    }).toList(),
                  ),
                  // const Divider(
                  //   thickness: 1,
                  // ),
                  ListTile(
                    minVerticalPadding: 5,
                    leading: Text(
                      "Sub Total",
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      "₹${totalPrice}",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    minVerticalPadding: 5,
                    leading: Text(
                      "Shipping Charge",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    trailing: Text(
                      "₹5",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    minVerticalPadding: 5,
                    leading: Text(
                      "Discount",
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      "₹${discountValue}",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    leading: Text(
                      "Payment Option",
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  RadioListTile(
                    value: AddressTypes.OnlinePayment,
                    groupValue: myType,
                    title: const Text("OnlinePayment"),
                    onChanged: (AddressTypes? value) {
                      setState(() {
                        myType = value!;
                      });
                    },
                    activeColor: Colors.black,
                    secondary: const Icon(
                      Icons.payment,
                      color: Colors.black,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
