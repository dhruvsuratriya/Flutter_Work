import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'In-App Purchase Demo',
      home: InAppPurchaseScreen(),
    );
  }
}

class InAppPurchaseScreen extends StatefulWidget {
  @override
  _InAppPurchaseScreenState createState() => _InAppPurchaseScreenState();
}

class _InAppPurchaseScreenState extends State<InAppPurchaseScreen> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  List<ProductDetails> _products = [];

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    // Fetch available products
    final ProductDetailsResponse response =
        await _inAppPurchase.queryProductDetails(
      // Add your product IDs here
      'your_product_id_here' as Set<String>,
    );

    if (response.error != null) {
      // Handle error
      return;
    }

    setState(() {
      _products = response.productDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('In-App Purchase Demo'),
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return ListTile(
            title: Text(product.title),
            subtitle: Text(product.description),
            trailing: Text(product.price),
            onTap: () {
              _purchaseProduct(product);
            },
          );
        },
      ),
    );
  }

  Future<void> _purchaseProduct(ProductDetails product) async {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    try {
      final PurchaseDetails purchaseDetails = (await _inAppPurchase
          .buyNonConsumable(purchaseParam: purchaseParam)) as PurchaseDetails;
      // Handle successful purchase
    } catch (e) {
      // Handle purchase error
      print('Error purchasing: $e');
    }
  }
}
