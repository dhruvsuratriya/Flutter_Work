import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../homescreen/1_home_screen.dart';
import '../providers/10_user_provider.dart';
import '../widget/costom_text_filed.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GetStorage box = GetStorage();
  late UserProvider userProvider;
  Future<User?> _googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;
      // print("signe in" + user.displayName);
      box.write('uid', user?.uid);
      userProvider.addUserData(
        currentUser: user!,
        userName: user!.displayName.toString(),
        userEmail: user.email.toString(),
        userImage: user!.photoURL.toString(),
        userId: user.uid,
      );

      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: ListView(
            children: [
              SizedBox(
                height: 41.h,
              ),
              CostomTextFiled(
                labText: "Email",
                controller: email,
                keyboardType: TextInputType.text,
              ),
              CostomTextFiled(
                labText: "Password",
                controller: password,
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 3.h,
              ),
              MaterialButton(
                onPressed: () {},
                color: Colors.black,
                height: 5.h,
                shape: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(6)),
                child: Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 0.1.h,
                    width: 39.w,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Text(
                    "Or",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Container(
                    height: 0.1.h,
                    width: 38.w,
                    color: Colors.grey,
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              SignInButton(
                Buttons.google,
                text: "Sign in with Google",
                onPressed: () {
                  _googleSignUp().then(
                    (value) => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
