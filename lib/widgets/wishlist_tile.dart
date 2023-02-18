// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/dimensions.dart';

class WishListTile extends StatefulWidget {
  final String pid;
  String pname = '';
  // ignore: prefer_typing_uninitialized_variables
  var price;
  WishListTile({
    Key? key,
    required this.pid,
    required this.pname,
    required this.price,
  }) : super(key: key);

  @override
  State<WishListTile> createState() => _WishListTileState();
}

class _WishListTileState extends State<WishListTile> {
  void deleteWishlistFunction() {
    FirebaseFirestore.instance
        .collection("wishlist")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userWishlist")
        .doc(widget.pid)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: Dimensions.h10, horizontal: Dimensions.w10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFECE6E9),
      ),
      child: ListTile(
        leading: IconButton(
            onPressed: () {
              deleteWishlistFunction();
            },
            icon: const Icon(
              Icons.close,
              color: AppColors.mainPurple,
            )),
        title: Text(
          widget.pname,
          style: TextStyle(
              color: AppColors.mainPurple,
              fontSize: Dimensions.h18,
              fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          "₹ ${widget.price}",
          style: TextStyle(
            color: Colors.black,
            fontSize: Dimensions.h18,
            fontWeight: FontWeight.w700,
          ),
        ),
        trailing: MaterialButton(
          color: AppColors.mainPurple,
          minWidth: Dimensions.w40,
          height: Dimensions.h40,
          onPressed: () {
            FirebaseFirestore.instance
                .collection("cart")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("userCart")
                .doc(widget.pid)
                .set({
              "pid": widget.pid,
              "uid": FirebaseAuth.instance.currentUser!.uid,
              "pname": widget.pname,
              "price": widget.price,
              "qty": 1,
            });
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: const Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
