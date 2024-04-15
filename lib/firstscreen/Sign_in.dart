import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:foodbites/providers/10_user_provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../homescreen/1_home_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
  // Future<UserCredential> signInWithGoogle() async {
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;
  //
  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Container(
              height: 40.h,
              width: double.infinity,
              color: Colors.white,
              child: Image.asset(
                'assets/images/food 2.jpg',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Center(
              child: Text(
                'Sign in to continue',
                style: TextStyle(fontSize: 22.sp, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Image.asset(
              'assets/images/Picsart_24-01-09_15-27-03-303.jpg',
              scale: 11,
            ),
            SizedBox(
              height: 5.h,
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
            SignInButton(
              Buttons.apple,
              text: "Sign in with Apple",
              onPressed: () {},
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              'By signing in you are already to our',
              style: TextStyle(fontSize: 15.sp, color: Colors.grey.shade600),
            ),
            SizedBox(
              height: 0.5.h,
            ),
            Text(
              'Terms and Privacy Policy',
              style: TextStyle(fontSize: 15.sp, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
