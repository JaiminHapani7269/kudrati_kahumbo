// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, prefer_typing_uninitialized_variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../utils/app_colors.dart';
import '../utils/dimensions.dart';

class SingleProductTile extends StatefulWidget {
  final String pid;
  final String pname;
  var price;
  bool isInFavorite = false;
  bool isInCart = false;

  SingleProductTile({
    Key? key,
    required this.pid,
    required this.pname,
    required this.price,
  }) : super(key: key);

  @override
  State<SingleProductTile> createState() => _SingleProductTileState();
}

class _SingleProductTileState extends State<SingleProductTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: Dimensions.h5, horizontal: Dimensions.w5),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFECE6E9),
          borderRadius: BorderRadius.circular(Dimensions.r12),
        ),
        child: ListTile(
          title: Text(
            widget.pname,
            style: TextStyle(
                color: AppColors.mainPurple,
                fontSize: Dimensions.h18,
                fontWeight: FontWeight.w700),
          ),
          subtitle: Text(
            "₹ ${widget.price}",
            style: TextStyle(color: Colors.black, fontSize: Dimensions.h15),
          ),
          trailing: Container(
            height: Dimensions.h80,
            width: Dimensions.w120,
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              children: [
                SizedBox(
                    height: Dimensions.h50,
                    width: Dimensions.w50,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            widget.isInFavorite = !widget.isInFavorite;
                            if (widget.isInFavorite == true) {
                              FirebaseFirestore.instance
                                  .collection("wishlist")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection("userWishlist")
                                  .doc(widget.pid)
                                  .set({
                                "pid": widget.pid,
                                "uid": FirebaseAuth.instance.currentUser!.uid,
                                "pname": widget.pname,
                                "price": widget.price,
                              }).then((value) => {
                                        Fluttertoast.showToast(
                                            toastLength: Toast.LENGTH_SHORT,
                                            msg:
                                                "Item is added to your Wishlist :)")
                                      });
                            } else {
                              FirebaseFirestore.instance
                                  .collection("wishlist")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection("userWishlist")
                                  .doc(widget.pid)
                                  .delete()
                                  .then((value) => {
                                        Fluttertoast.showToast(
                                            toastLength: Toast.LENGTH_SHORT,
                                            msg:
                                                "Item is removed from your Wishlist :)")
                                      });
                            }
                          });
                        },
                        icon: widget.isInFavorite
                            ? const Icon(
                                Icons.favorite,
                                color: AppColors.mainPurple,
                              )
                            : const Icon(
                                Icons.favorite_border_outlined,
                                color: AppColors.mainPurple,
                              ))),
                SizedBox(width: Dimensions.w5),
                Container(
                    height: Dimensions.h50,
                    width: Dimensions.w50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        Colors.black.withOpacity(0.6),
                        AppColors.mainPurple,
                      ]),
                    ),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            widget.isInCart = !widget.isInCart;
                            if (widget.isInCart == true) {
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
                              Fluttertoast.showToast(
                                  toastLength: Toast.LENGTH_SHORT,
                                  msg: "Item is added to the cart :)");
                            } else {
                              FirebaseFirestore.instance
                                  .collection("cart")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection("userCart")
                                  .doc(widget.pid)
                                  .delete();
                              Fluttertoast.showToast(
                                  toastLength: Toast.LENGTH_SHORT,
                                  msg: "Item is removed from the cart :)");
                            }
                          });
                        },
                        icon: Icon(
                          widget.isInCart
                              ? Icons.delete
                              : Icons.shopping_cart_outlined,
                          color: Colors.white,
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
