import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 240,
            ),
            Center(
              child: TextField(
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
              onPressed: () {},
              height: 50,
              minWidth: 320,
              color: Colors.black,
              splashColor: Colors.grey,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                "Register",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
