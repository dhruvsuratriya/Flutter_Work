import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentDemo extends StatefulWidget {
  const PaymentDemo({super.key});

  @override
  State<PaymentDemo> createState() => _PaymentDemoState();
}

class _PaymentDemoState extends State<PaymentDemo> {
  Razorpay razorpay = Razorpay();
  @override
  void initState() {
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    // TODO: implement initState
    super.initState();
  }

  _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('SUCCESS');
  }

  _handlePaymentError(PaymentFailureResponse response) {
    print('ERROR');
  }

  _handleExternalWallet(ExternalWalletResponse response) {
    print('WALLET');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              color: Colors.black,
              onPressed: () {
                var options = {
                  'key': 'rzp_test_EM5urUrcGkdJvm',
                  'amount': 100,
                  'name': 'DS Manufacturing',
                  'description': 'Fine T-Shirt',
                  'prefill': {
                    'contact': '8888888888',
                    'email': 'test@razorpay.com'
                  }
                };
                razorpay.open(options);
              },
              child: Text(
                'pay',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
