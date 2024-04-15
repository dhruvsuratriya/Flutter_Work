import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodbites/model/delivery_address_model.dart';

class CheckOutProvider with ChangeNotifier {
  bool islodding = false;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController society = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController setLocation = TextEditingController();
  void validator(context, myType) async {
    if (firstName.text.isEmpty) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        const SnackBar(
          content: Text("Please Enter Firstname"),
        ),
      );
    } else if (lastName.text.isEmpty) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        const SnackBar(
          content: Text("Please Enter Lastname"),
        ),
      );
    } else if (mobileNo.text.isEmpty) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        const SnackBar(
          content: Text("Please Enter MobileNo"),
        ),
      );
    } else if (society.text.isEmpty) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        const SnackBar(
          content: Text("Please Enter Society"),
        ),
      );
    } else if (area.text.isEmpty) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        const SnackBar(
          content: Text("Please Enter Area"),
        ),
      );
    } else if (city.text.isEmpty) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        const SnackBar(
          content: Text("Please Enter City"),
        ),
      );
    } else if (pincode.text.isEmpty) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        const SnackBar(
          content: Text("Please Enter Pincode"),
        ),
      );
    }
    // else if (setLocation.text.isEmpty) {
    //   ScaffoldMessenger.of(context as BuildContext).showSnackBar(
    //     SnackBar(
    //       content: Text("Please Enter Location"),
    //     ),
    //   );
    // }
    else {
      islodding = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("AddDeliveryAddress")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set(
        {
          "firstName": firstName.text,
          "lastName": lastName.text,
          "mobileNo": mobileNo.text,
          "society": society.text,
          "area": area.text,
          "city": city.text,
          "pin code": pincode.text,
          "setLocation": setLocation.text,
          "addressType": myType.toString(),
        },
      ).then((value) async {
        islodding = false;
        notifyListeners();
        await ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          const SnackBar(
            content: Text("Confirm Address"),
          ),
        );
        Navigator.of(context).pop();
        notifyListeners();
      });
      notifyListeners();
    }
  }

  List<DeliveryAddressModel> deliveryAddressList = [];
  getDeliveryAddressData() async {
    List<DeliveryAddressModel> newList = [];
    DeliveryAddressModel deliveryAddressModel;
    DocumentSnapshot _db = await FirebaseFirestore.instance
        .collection("AddDeliveryAddress")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    if (_db.exists) {
      deliveryAddressModel = DeliveryAddressModel(
        firstName: _db.get("firstName"),
        lastName: _db.get("lastName"),
        mobilNo: _db.get("mobileNo"),
        society: _db.get("society"),
        area: _db.get("area"),
        city: _db.get("city"),
        pincode: _db.get("pin code"),
        addressType: _db.get("addressType"),
      );
      newList.add(deliveryAddressModel);
      notifyListeners();
    }
    deliveryAddressList = newList;
    notifyListeners();
  }

  List<DeliveryAddressModel> get getDeliveryAddressList {
    return deliveryAddressList;
  }
}
