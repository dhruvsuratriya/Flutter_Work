import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Text(
            "${box.read('email')}",
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(
            height: 32,
          ),
          MaterialButton(
            onPressed: () {
              box.erase();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
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
              "Register",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
