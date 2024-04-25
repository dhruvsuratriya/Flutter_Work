import 'dart:convert';

import 'package:api_task/User_Detail_App_Bar/personal_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'address.dart';
import 'company.dart';

class UserDetail extends StatefulWidget {
  const UserDetail({
    super.key,
    this.personal,
    this.email,
    this.address,
    this.city,
    this.zipcode,
    this.company,
  });
  final personal;
  final email;
  final address;
  final city;
  final zipcode;
  final company;

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> with TickerProviderStateMixin {
  TabController? tabController;
  Future getData() async {
    var data;
    http.Response response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
    } else {
      print('STATUS ${response.statusCode}');
    }
    return data!;
  }

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        shadowColor: Colors.black,
        backgroundColor: Colors.black,
        title: Text(
          "Detail",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: TabBar(
            controller: tabController,
            indicatorColor: Colors.white,
            labelPadding: EdgeInsets.only(bottom: 4),
            indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
            indicatorWeight: 2,
            tabs: [
              Text(
                'Personal Detail',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                'Address',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                'Company',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          PersonalDetail(
              personal: widget.personal.toString(),
              email: widget.email.toString()),
          Address(
            address: widget.address.toString(),
            city: widget.city.toString(),
            zipcode: widget.zipcode,
          ),
          Company(
            company: widget.company.toString(),
          ),
        ],
      ),
    );
  }
}
