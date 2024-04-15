import 'package:flutter/material.dart';

class CostomTextFiled extends StatefulWidget {
  const CostomTextFiled({
    super.key,
    required this.controller,
    required this.labText,
    required this.keyboardType,
  });

  final String labText;
  final TextEditingController controller;
  final TextInputType keyboardType;

  @override
  State<CostomTextFiled> createState() => _CostomTextFiledState();
}

class _CostomTextFiledState extends State<CostomTextFiled> {
  @override
  Widget build(BuildContext context) {
    // TextEditingController controller = TextEditingController();
    return TextField(
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      cursorColor: Colors.black,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: widget.labText,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        // enabledBorder: UnderlineInputBorder(
        //   borderSide: BorderSide(color: Colors.black),
        // ),
      ),
    );
  }
}
