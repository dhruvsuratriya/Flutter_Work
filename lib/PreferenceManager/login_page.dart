import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controller = TextEditingController();
  static GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 240,
            ),
            Center(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  constraints: BoxConstraints.expand(width: 320, height: 55),
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Password',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                constraints: BoxConstraints.expand(width: 320, height: 55),
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            MaterialButton(
              onPressed: () async {
                await box.write('email', controller.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              height: 50,
              minWidth: 320,
              color: Colors.black,
              splashColor: Colors.grey,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                "Log In",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
