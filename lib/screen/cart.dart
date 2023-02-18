// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:kudrati_kahumbo/model/user_model.dart';
import 'package:kudrati_kahumbo/provider/cart_provider.dart';
import 'package:kudrati_kahumbo/screen/checkout_page.dart';
import 'package:kudrati_kahumbo/utils/dimensions.dart';
import 'package:kudrati_kahumbo/widgets/cart_tile.dart';
import 'package:provider/provider.dart';
import '../utils/app_colors.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();
    int totalAmount = cartProvider.totalAmount();
    if (cartProvider.getCartList.isEmpty) {
      setState(() {
        totalAmount = 0;
      });
    }
    List products = [];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainPurple,
        elevation: 5,
        centerTitle: true,
        title: const Text(
          "Cart",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: cartProvider.cartList.isEmpty
          ? Center(
              child: Text(
                'Cart is empty',
                style: TextStyle(
                    color: AppColors.mainPurple, fontSize: Dimensions.h18),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemCount: cartProvider.getCartList.length,
              itemBuilder: (context, index) {
                var data = cartProvider.cartList[index];

                products.add("${data.pname} -- ${data.qty}");

                return CartTile(
                    productId: data.pid,
                    productName: data.pname,
                    prodcutPrice: data.price,
                    qty: data.qty);
              }),
      bottomNavigationBar: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.r24),
            topRight: Radius.circular(Dimensions.r24),
          ),
          color: AppColors.mainPurple.withOpacity(0.2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListTile(
              title: Text(
                "Total:",
                style: TextStyle(
                  color: AppColors.mainPurple,
                  fontSize: Dimensions.h20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Text(
                "₹ $totalAmount",
                style: TextStyle(
                  color: AppColors.mainPurple,
                  fontSize: Dimensions.h20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              child: GestureDetector(
                onTap: () {
                  print(products);
                  // FirebaseFirestore.instance
                  //     .collection("order")
                  //     .doc(FirebaseAuth.instance.currentUser!.uid)
                  //     .collection("userOrder")
                  //     .doc(loggedInUser.mobile)
                  //     .set({
                  //   "name": loggedInUser.c_name,
                  //   "total": totalAmount,
                  //   "product": ["jamun -- 2", "apple -- 3"],
                  //   "date": DateTime.now(),
                  // }).whenComplete(() => Navigator.of(context).push(
                  //         MaterialPageRoute(
                  //             builder: (context) => CheckoutPage())));
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CheckoutPage()));
                },
                child: Container(
                  margin: EdgeInsets.all(Dimensions.h18),
                  height: Dimensions.h55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.mainPurple,
                      borderRadius: BorderRadius.circular(Dimensions.r20)),
                  child: Center(
                    child: Text(
                      "Procced To Checkout",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.h20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
