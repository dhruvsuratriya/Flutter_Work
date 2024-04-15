import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:foodbites/firstscreen/Sign_in.dart';
import 'package:get_storage/get_storage.dart';

import '1_home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  GetStorage box = GetStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(
      Duration(seconds: 2),
      () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  box.read('uid') == null ? SignIn() : HomeScreen(),
            ));
      },
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Stack(
          children: [
            SizedBox(
              height: 100.h,
              width: 100.w,
              child: Image.asset(
                "assets/images/123.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 100.h,
              width: 100.w,
              color: Colors.black38,
              child: Image.asset(
                "assets/images/Picsart_24-01-09_15-27-03-303.jpg",
                scale: 12,
              ),
            )
          ],
        )),
      ),
    );
  }
}
