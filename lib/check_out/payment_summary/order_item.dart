import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:foodbites/model/12_review_cart_model.dart';

class OrderItem extends StatefulWidget {
  const OrderItem({
    super.key,
    required this.e,
  });
  final ReviewCartModel e;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  late bool isTrue;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        widget.e.cartImage,
        width: 60,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.e.cartName,
            style: TextStyle(color: Colors.grey),
          ),
          Spacer(),
          Text(
            "${widget.e.cartQuantity}",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(
            width: 18.w,
          ),
          Text(
            "₹${widget.e.cartPrice}",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
      subtitle: Text("Fresh Food"),
    );
  }
}
