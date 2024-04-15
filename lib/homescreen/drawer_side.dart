import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:foodbites/providers/10_user_provider.dart';

import '../myprofile/4_myprofile.dart';
import '../review/7_review_screen.dart';
import '../wishlist/15_wish_list.dart';
import '1_home_screen.dart';

class DrawerSide extends StatefulWidget {
  const DrawerSide({super.key, required this.userProvider});
  final UserProvider userProvider;

  @override
  State<DrawerSide> createState() => _DrawerSideState();
}

class _DrawerSideState extends State<DrawerSide> {
  Widget listTile({
    required IconData icon,
    required String title,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        size: 25.sp,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var userData = widget.userProvider.currenUsertData;
    return Drawer(
      width: 80.w,
      child: Container(
        color: Color(0xffB6BBC4),
        child: ListView(
          children: [
            DrawerHeader(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 43,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(userData.userImage ??
                          "assets/images/Picsart_24-01-09_15-27-03-303.jpg"),
                    ),
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        userData.userName,
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      Text(
                        userData.userEmail,
                        style: TextStyle(fontSize: 13.sp),
                      ),
                    ],
                  )
                ],
              ),
            ),
            InkResponse(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
              child: listTile(
                icon: Icons.home_outlined,
                title: 'Home',
              ),
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
                icon: Icons.shop_outlined,
                title: 'Review Cart',
              ),
            ),
            InkResponse(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MyProfile(userProvider: widget.userProvider),
                  ),
                );
              },
              child: listTile(
                icon: Icons.person_outlined,
                title: 'My Profile',
              ),
            ),
            InkResponse(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WishList(),
                  ),
                );
              },
              child: listTile(
                icon: Icons.favorite_border,
                title: 'Wishlist',
              ),
            ),
            listTile(
              icon: Icons.notifications_outlined,
              title: 'Notification',
            ),
            listTile(
              icon: Icons.star_border,
              title: 'Rating',
            ),
            listTile(
              icon: Icons.copy_outlined,
              title: 'Raise',
            ),
            listTile(
              icon: Icons.format_quote_outlined,
              title: 'FAQs',
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Text(
                "Contact Support",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 12.h,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.call_outlined),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                            "+91 8140380825",
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        children: [
                          Icon(Icons.email_outlined),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                            userData.userEmail,
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
