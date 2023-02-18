// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, prefer_typing_uninitialized_variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/app_colors.dart';
import '../utils/dimensions.dart';

class CartTile extends StatefulWidget {
  String productName = '';
  var prodcutPrice;
  int qty;
  final String productId;
  CartTile({
    Key? key,
    required this.productName,
    required this.prodcutPrice,
    required this.qty,
    required this.productId,
  }) : super(key: key);

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  int quantity = 1;

  void qtyFunction() {
    FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCart")
        .doc(widget.productId)
        .update({
      "qty": quantity,
    });
  }

  void deleteCartFunction() {
    FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCart")
        .doc(widget.productId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // height: Dimensions.h120,
          width: double.infinity,
          margin: EdgeInsets.symmetric(
              vertical: Dimensions.h10, horizontal: Dimensions.w10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.r12),
            color: const Color(0xFFECE6E9),
          ),
          child: ListTile(
            leading: IconButton(
              onPressed: () {
                deleteCartFunction();
              },
              icon: const Icon(
                Icons.close,
                color: AppColors.mainPurple,
              ),
            ),
            title: Text(
              widget.productName,
              style: TextStyle(
                color: AppColors.mainPurple,
                fontSize: Dimensions.h18,
                fontWeight: FontWeight.w700,
              ),
            ),
            subtitle: Text(
              "₹ ${widget.prodcutPrice} x ${widget.qty} = ₹ ${widget.prodcutPrice * widget.qty}",
              style: TextStyle(
                color: Colors.black,
                fontSize: Dimensions.h15,
                fontWeight: FontWeight.w700,
              ),
            ),
            trailing: SizedBox(
              height: Dimensions.h40,
              width: Dimensions.h110,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IncrementDecrement(
                      onPrecced: () {
                        setState(() {
                          if (quantity > 1) {
                            quantity--;
                            qtyFunction();
                          }
                        });
                      },
                      icon: Icons.remove_circle),
                  Text(
                    "${widget.qty}",
                    style: TextStyle(
                        fontSize: Dimensions.h20, fontWeight: FontWeight.bold),
                  ),
                  IncrementDecrement(
                      onPrecced: () {
                        setState(() {
                          if (quantity < 5) {
                            quantity++;
                            qtyFunction();
                          } else {
                            Fluttertoast.showToast(
                                msg: "At A time only 5 Item Added");
                          }
                        });
                      },
                      icon: Icons.add_circle),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class IncrementDecrement extends StatelessWidget {
  final Function()? onPrecced;
  final IconData icon;
  const IncrementDecrement({
    Key? key,
    this.onPrecced,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPrecced,
        icon: Icon(icon, size: Dimensions.h30, color: AppColors.mainPurple));
  }
}
