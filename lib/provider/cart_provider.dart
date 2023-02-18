// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:kudrati_kahumbo/model/cart_model.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> cartList = [];
  CartModel? cartModel;
  Future getCartData() async {
    List<CartModel> newCartList = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCart")
        .get();

    querySnapshot.docs.forEach((element) {
      cartModel = CartModel.fromDocument(element);
      notifyListeners();
      newCartList.add(cartModel!);
    });

    cartList = newCartList;
    notifyListeners();
  }

  List<CartModel> get getCartList {
    return cartList;
  }

  int totalAmount() {
    int totalAmount = 0;
    cartList.forEach((element) {
      totalAmount += element.price * element.qty;
    });
    return totalAmount;
  }
}
