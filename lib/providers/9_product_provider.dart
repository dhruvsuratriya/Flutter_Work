import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/8_product_model.dart';

class ProductProvider with ChangeNotifier {
  ProductModel? productModel;
  List<ProductModel> search = [];

  ////////////// allCategories ////////////////

  List<ProductModel> allCategories = [];

  fatchAllCategories() async {
    List<ProductModel> newList = [];
    QuerySnapshot data =
        await FirebaseFirestore.instance.collection("All Categories").get();

    data.docs.forEach(
      (element) {
        productModel = ProductModel(
          productImage: element.get("productimage"),
          productName: element.get("productname"),
          productPrice: element.get("productprice"),
          productId: element.get("productid"),
          productQuantity: 0,
          // subtitle: element.get("subtitle"),
        );
        search.add(productModel!);
        newList.add(productModel!);
      },
    );
    allCategories = newList;
    notifyListeners();
  }

  List<ProductModel> get getAllCategoriesList {
    return allCategories;
  }

  ///////////////////// popularProduct ///////////////////

  List<ProductModel> freshPopularProduct = [];

  fatchFreshPopularData() async {
    List<ProductModel> newList = [];
    QuerySnapshot data =
        await FirebaseFirestore.instance.collection("PopularFood").get();

    data.docs.forEach(
      (element) {
        productModel = ProductModel(
          productImage: element.get("productimage"),
          productName: element.get("productname"),
          productPrice: element.get("productprice"),
          productId: element.get("productid"),
          productQuantity: 0,
          // subtitle: element.get("subtitle"),
        );
        search.add(productModel!);
        newList.add(productModel!);
      },
    );
    freshPopularProduct = newList;
    notifyListeners();
  }

  List<ProductModel> get getFreshPopularDataList {
    return freshPopularProduct;
  }

  ///////////////////// search allproduct ///////////////////////
}
