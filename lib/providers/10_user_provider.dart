import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../model/16_user_model.dart';

class UserProvider with ChangeNotifier {
  void addUserData(
      {required User currentUser,
      required String userName,
      required String userEmail,
      required String userImage,
      required String userId}) async {
    await FirebaseFirestore.instance
        .collection("userData")
        .doc(currentUser.uid)
        .set(
      {
        "userName": userName,
        "userEmail": userEmail,
        "userImage": userImage,
        "userUid": currentUser.uid,
      },
    );
  }

  late UserModel currentData;

  void getUserData() async {
    UserModel userModel;
    var value = await FirebaseFirestore.instance
        .collection("userData")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    if (value.exists) {
      userModel = UserModel(
        userName: value.get("userName"),
        userEmail: value.get("userEmail"),
        userImage: value.get("userImage"),
        userUid: value.get("userUid"),
      );
      currentData = userModel;
      notifyListeners();
    }
  }

  UserModel get currenUsertData {
    return currentData;
  }
}
