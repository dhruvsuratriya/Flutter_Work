import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:foodbites/homescreen/splash_screen.dart';
import 'package:foodbites/providers/10_user_provider.dart';
import 'package:foodbites/providers/13_review_cart_provider.dart';
import 'package:foodbites/providers/14_wish_list_provider.dart';
import 'package:foodbites/providers/9_product_provider.dart';
import 'package:foodbites/providers/check_out_provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FlutterSizer(
      builder: (Context, Orientation, ScreenType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<ProductProvider>(
              create: (context) => ProductProvider(),
            ),
            ChangeNotifierProvider<UserProvider>(
              create: (context) => UserProvider(),
            ),
            ChangeNotifierProvider<ReviewCartProvider>(
              create: (context) => ReviewCartProvider(),
            ),
            ChangeNotifierProvider<WishListProvider>(
              create: (context) => WishListProvider(),
            ),
            ChangeNotifierProvider<CheckOutProvider>(
              create: (context) => CheckOutProvider(),
            ),
          ],
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            // home: SplashScreen(),

            home: SplashScreen(),
          ),
        );
      },
    );
  }
}
