import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kudrati_kahumbo/widgets/wishlist_tile.dart';

import '../utils/app_colors.dart';
import '../utils/dimensions.dart';

class WishListPage extends StatelessWidget {
  const WishListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainPurple,
        elevation: 5,
        centerTitle: true,
        title: const Text(
          "Wishlist",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("wishlist")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("userWishlist")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (!streamSnapshot.hasData) {
              return const Center(
                  child: CircularProgressIndicator(
                color: AppColors.mainPurple,
              ));
            }
            return streamSnapshot.data!.docs.isNotEmpty
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = streamSnapshot.data!.docs[index];
                      if (!streamSnapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.mainPurple,
                          ),
                        );
                      }
                      return WishListTile(
                        pid: data["pid"],
                        pname: data["pname"],
                        price: data["price"],
                      );
                    })
                : Center(
                    child: Text(
                      "Wishlist is Empty !",
                      style: TextStyle(
                        color: AppColors.mainPurple,
                        fontSize: Dimensions.h18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
          }),
    );
  }
}
