import 'package:flutter/material.dart';

class Address extends StatefulWidget {
  const Address({super.key, this.address, this.city, this.zipcode});
  final address;
  final city;
  final zipcode;

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
              child: Container(
            height: 100,
            width: 300,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey),
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
                  "Street:${widget.address.toString()}",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "City:${widget.city.toString()}",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "ZipCode:${widget.zipcode.toString()}",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
