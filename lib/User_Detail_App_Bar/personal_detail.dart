import 'package:flutter/material.dart';

class PersonalDetail extends StatefulWidget {
  const PersonalDetail({super.key, this.personal, this.email});

  final personal;
  final email;
  @override
  State<PersonalDetail> createState() => _PersonalDetailState();
}

class _PersonalDetailState extends State<PersonalDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
                height: 100,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 0),
                          blurRadius: 2,
                          spreadRadius: 2)
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "UserName:${widget.personal.toString()}",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "Email:${widget.email.toString()}",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
