// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kudrati_kahumbo/utils/dimensions.dart';
import 'package:kudrati_kahumbo/widgets/cart_tile.dart';
import '../utils/app_colors.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainPurple,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Cart",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("cart")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("userCart")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (!streamSnapshot.hasData) {
              return const Center(
                  child: CircularProgressIndicator(
                color: AppColors.mainPurple,
              ));
            }
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
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
                  return streamSnapshot.data!.docs.isEmpty
                      ? const Center(
                          child: Text("Cart Is Empty !"),
                        )
                      : CartTile(
                          productId: data["pid"],
                          productName: data['pname'],
                          prodcutPrice: data['price'],
                          qty: data['qty']);
                });
          }),
      bottomNavigationBar: SizedBox(
        child: GestureDetector(
          onTap: () {},
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
    );
  }
}
