import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:foodbites/providers/check_out_provider.dart';
import 'package:provider/provider.dart';

import '../../widget/costom_text_filed.dart';
import '../google_map/google_map.dart';

class AddDeliveryAddress extends StatefulWidget {
  const AddDeliveryAddress({super.key});

  @override
  State<AddDeliveryAddress> createState() => _AddDeliveryAddressState();
}

enum AddressTypes {
  Home,
  Work,
  Other,
}

class _AddDeliveryAddressState extends State<AddDeliveryAddress> {
  var myType = AddressTypes.Home;
  @override
  Widget build(BuildContext context) {
    CheckOutProvider checkoutProvider = Provider.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Delivery Address"),
          backgroundColor: Colors.black,
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: 1.h, left: 4.w, right: 4.w),
          child: Container(
            height: 6.h,
            child: checkoutProvider.islodding == false
                ? MaterialButton(
                    onPressed: () {
                      checkoutProvider.validator(context, myType);
                    },
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Add Address",
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 4.w,
          ),
          child: ListView(
            children: [
              CostomTextFiled(
                labText: "First name",
                controller: checkoutProvider.firstName,
                keyboardType: TextInputType.text,
              ),
              CostomTextFiled(
                labText: "Last name",
                controller: checkoutProvider.lastName,
                keyboardType: TextInputType.text,
              ),
              CostomTextFiled(
                labText: "Mobile no",
                controller: checkoutProvider.mobileNo,
                keyboardType: TextInputType.number,
              ),
              CostomTextFiled(
                labText: "Society",
                controller: checkoutProvider.society,
                keyboardType: TextInputType.text,
              ),
              CostomTextFiled(
                labText: "Area",
                controller: checkoutProvider.area,
                keyboardType: TextInputType.text,
              ),
              CostomTextFiled(
                labText: "City",
                controller: checkoutProvider.city,
                keyboardType: TextInputType.text,
              ),
              CostomTextFiled(
                labText: "Pincode",
                controller: checkoutProvider.pincode,
                keyboardType: TextInputType.number,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CostomGoogleMap(),
                    ),
                  );
                },
                child: Container(
                  height: 4.h,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      Text("Set Location"),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                title: Text("Address Type"),
              ),
              RadioListTile(
                value: AddressTypes.Home,
                groupValue: myType,
                title: Text("Home"),
                onChanged: (AddressTypes? value) {
                  setState(() {
                    myType = value!;
                  });
                },
                activeColor: Colors.black,
                secondary: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
              ),
              RadioListTile(
                value: AddressTypes.Work,
                groupValue: myType,
                title: Text("Work"),
                onChanged: (AddressTypes? value) {
                  setState(() {
                    myType = value!;
                  });
                },
                activeColor: Colors.black,
                secondary: Icon(
                  Icons.work,
                  color: Colors.black,
                ),
              ),
              RadioListTile(
                value: AddressTypes.Other,
                groupValue: myType,
                title: Text("Other"),
                onChanged: (AddressTypes? value) {
                  setState(() {
                    myType = value!;
                  });
                },
                activeColor: Colors.black,
                secondary: Icon(
                  Icons.other_houses,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
