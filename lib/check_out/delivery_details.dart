import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:foodbites/check_out/payment_summary/payment_summary.dart';
import 'package:foodbites/check_out/single_delivery_item.dart';
import 'package:foodbites/providers/check_out_provider.dart';
import 'package:provider/provider.dart';

import '../model/delivery_address_model.dart';
import 'add_delivery_address/add_delivery_address.dart';

class DeliveryDetails extends StatefulWidget {
  const DeliveryDetails({super.key});

  @override
  State<DeliveryDetails> createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  bool isAddress = false;
  late DeliveryAddressModel value;
  @override
  Widget build(BuildContext context) {
    CheckOutProvider deliveryAddressProvider = Provider.of(context);
    deliveryAddressProvider.getDeliveryAddressData();
    // print(value.firstName);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Delivery Details"),
          backgroundColor: Colors.black,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(
            Icons.add,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddDeliveryAddress(),
              ),
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: 2.h, left: 4.w, right: 4.w),
          child: Container(
            height: 6.h,
            child: MaterialButton(
              onPressed: () {
                deliveryAddressProvider.getDeliveryAddressList.isEmpty
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddDeliveryAddress(),
                        ),
                      )
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentSummary(
                            deliverAddressList: value,
                          ),
                        ),
                      );
              },
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: deliveryAddressProvider.getDeliveryAddressList.isEmpty
                  ? Text(
                      'Add New Address',
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    )
                  : Text(
                      'Payment',
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    ),
            ),
          ),
        ),
        body: ListView(
          children: [
            ListTile(
                title: Text(
                  "Delivery To",
                  style: TextStyle(fontSize: 17.sp),
                ),
                leading: Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 30,
                )),
            Divider(
              height: 5,
              thickness: 1,
            ),
            deliveryAddressProvider.getDeliveryAddressList.isEmpty
                ? Container(
                    child: Center(
                      child: Text(
                        "No Data",
                        style: TextStyle(fontSize: 15.sp),
                      ),
                    ),
                  )
                : Column(
                    children:
                        deliveryAddressProvider.getDeliveryAddressList.map((e) {
                      setState(() {
                        value = e;
                      });
                      return SingleDeliveryItem(
                          title: "${e.firstName} ${e.lastName}",
                          address:
                              "${e.society},${e.area},${e.city}\n${e.pincode}",
                          number: "Mob no : ${e.mobilNo}",
                          addressType: e.addressType == "AddressType.Other"
                              ? "Other"
                              : e.addressType == "AddressType.Home"
                                  ? "Home"
                                  : "Work");
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }
}
