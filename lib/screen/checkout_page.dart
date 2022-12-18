import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/dimensions.dart';
import '../widgets/cart_tile.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainPurple,
        elevation: 5,
        centerTitle: true,
        title: const Text(
          "Checkout",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("cart")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection("userCart")
                    .snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (!streamSnapshot.hasData) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: AppColors.mainPurple,
                    ));
                  }
                  return streamSnapshot.data!.docs.isEmpty
                      ? Center(
                          child: Text(
                            "Cart Is Empty !",
                            style: TextStyle(
                              color: AppColors.mainPurple,
                              fontSize: Dimensions.h18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : ListView.builder(
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
          ),
          Flexible(
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    "Sub Total:",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimensions.h15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Text(
                    "\$120",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimensions.h15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Discount:",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimensions.h15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Text(
                    "0%",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimensions.h15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Shipping Fee:",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimensions.h15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Text(
                    "Free",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: Dimensions.h15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 3,
                  color: Colors.black54,
                ),
                ListTile(
                  title: Text(
                    "Total:",
                    style: TextStyle(
                      color: AppColors.mainPurple,
                      fontSize: Dimensions.h18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Text(
                    "\$120",
                    style: TextStyle(
                      color: AppColors.mainPurple,
                      fontSize: Dimensions.h18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
                "Buy",
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
