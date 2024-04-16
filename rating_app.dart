import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

var appId = "6779a243c7d0463b9b0338d98320db17";

class RateApp extends StatefulWidget {
  const RateApp({super.key});

  @override
  State<RateApp> createState() => _RateAppState();
}

class _RateAppState extends State<RateApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rating App"),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: MaterialButton(
          onPressed: () {
            CustomRatingBottomSheet.showFeedBackBottomSheet(context: context);
          },
          child: Text("Rate App"),
        ),
      ),
    );
  }
}

class CustomRatingBottomSheet {
  CustomRatingBottomSheet._();

  static Future<void> showFeedBackBottomSheet({
    required BuildContext context,
  }) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            width: width,
            height: height * 0.55,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                  ),
                ),
                Image.network(
                  "https://i.pinimg.com/236x/4b/05/0c/4b050ca4fcf588eedc58aa6135f5eecf.jpg",
                  scale: 4,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    "HY Dhruv",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                SizedBox(
                  height: height * 0.2,
                ),
                SizedBox(
                  height: 10,
                ),
                RatingBar.builder(
                    glow: false,
                    allowHalfRating: true,
                    unratedColor: Colors.grey.shade300,
                    itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                    onRatingUpdate: (rating) {
                      if (rating.toInt() < 3) {
                        Navigator.pop(context);
                        log("Less then 3" as num);
                      } else {
                        Navigator.pop(context);
                        log("grater then 3" as num);
                        LaunchReview.launch(
                          androidAppId : "",
                        );
                      }
                    }),
                Text(
                  "Tap the starts",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
