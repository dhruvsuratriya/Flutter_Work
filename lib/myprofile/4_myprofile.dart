import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:foodbites/firstscreen/Sign_in.dart';
import 'package:foodbites/providers/10_user_provider.dart';

import '../check_out/delivery_details.dart';
import '../homescreen/drawer_side.dart';
import '../review/7_review_screen.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({
    super.key,
    required this.userProvider,
  });
  final UserProvider userProvider;

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  Widget listTile({required IconData icon, required String title}) {
    return Column(
      children: [
        Divider(
          height: 1.h,
        ),
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: Icon(Icons.arrow_forward_ios),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var userData = widget.userProvider.currenUsertData;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: Text('My Profile'),
        ),
        drawer: DrawerSide(
          userProvider: widget.userProvider,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 12.h,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.black),
                ),
                Container(
                  height: 76.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 1.w),
                            child: Container(
                              height: 7.h,
                              width: 70.w,
                              padding: EdgeInsets.only(left: 10.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        userData.userName,
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    userData.userEmail,
                                    style: TextStyle(fontSize: 15.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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
                        child: listTile(
                          icon: Icons.shopping_bag_outlined,
                          title: "My Order",
                        ),
                      ),
                      InkResponse(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DeliveryDetails(),
                            ),
                          );
                        },
                        child: listTile(
                          icon: Icons.location_on_outlined,
                          title: "My Delivery Address",
                        ),
                      ),
                      listTile(
                        icon: Icons.person_2_outlined,
                        title: "Refer A Friend",
                      ),
                      listTile(
                        icon: Icons.file_copy_outlined,
                        title: "Terms & Condition",
                      ),
                      listTile(
                        icon: Icons.policy_outlined,
                        title: "Privacy Policy",
                      ),
                      listTile(
                        icon: Icons.add_chart,
                        title: "About",
                      ),
                      InkResponse(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignIn(),
                              ));
                        },
                        child: listTile(
                          icon: Icons.exit_to_app,
                          title: "Log Out",
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.w, top: 5.8.h),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(
                    userData.userImage ??
                        "assets/images/Picsart_24-01-09_15-27-03-303.jpg",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
