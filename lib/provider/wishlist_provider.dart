import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class WishListProvider with ChangeNotifier {
  void wishlist({
    required pid,
    required uid,
    required pname,
    required price,
  }) {
    FirebaseFirestore.instance
        .collection("wishlist")
        .doc(uid)
        .collection("userWishlist")
        .doc(pid)
        .set({
      "pid": pid,
      "uid": pid,
      "pname": pname,
      "price": price,
    });
  }
}
