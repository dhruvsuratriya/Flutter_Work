import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class SingleDeliveryItem extends StatelessWidget {
  const SingleDeliveryItem({
    super.key,
    required this.title,
    required this.address,
    required this.number,
    this.addressType,
  });
  final String title;
  final String address;
  final String number;
  final addressType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 14.sp),
                ),
                Container(
                  height: 4.h,
                  width: 24.w,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      addressType,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            leading: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.grey,
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 0.5.h,
                ),
                Text(
                  address,
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Text(number),
              ],
            ),
          ),
        ),
        Divider(
          height: 5,
          thickness: 1,
        ),
      ],
    );
  }
}
