// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/app_colors.dart';
import '../utils/dimensions.dart';

class CategoryProductScreen extends StatefulWidget {
  final String id;
  final String collection;
  const CategoryProductScreen({
    Key? key,
    required this.id,
    required this.collection,
  }) : super(key: key);

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColors.mainPurple,
        centerTitle: false,
        elevation: 0,
        title: SvgPicture.asset(
          "assets/images/Group.svg",
        ),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.favorite_outline)),
          IconButton(
              onPressed: () => Navigator.of(context).pushNamed('cart'),
              icon: const Icon(CupertinoIcons.shopping_cart)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: Dimensions.w15, right: Dimensions.w15),
        child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("category")
              .doc(widget.id)
              .collection(widget.collection)
              .get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainPurple,
                ),
              );
            }
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data!.docs[index];
                  return Padding(
                    padding: EdgeInsets.all(Dimensions.h5),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.w10, vertical: Dimensions.h5),
                      decoration: BoxDecoration(
                          color: const Color(0xFFECE6E9),
                          borderRadius: BorderRadius.circular(Dimensions.r12)),
                      child: ListTile(
                        title: Text(
                          data["pname"],
                          style: TextStyle(
                            color: AppColors.mainPurple,
                            fontSize: Dimensions.h24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        trailing: Container(
                          height: Dimensions.h80,
                          width: Dimensions.w120,
                          padding: EdgeInsets.only(left: Dimensions.w12),
                          child: Row(
                            children: [
                              SizedBox(
                                  height: Dimensions.h50,
                                  width: Dimensions.w50,
                                  child: IconButton(
                                      onPressed: () {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Item is added to your Wishlist :)");
                                      },
                                      icon: const Icon(
                                        Icons.favorite_border_outlined,
                                        color: AppColors.mainPurple,
                                      ))),
                              SizedBox(width: Dimensions.w5),
                              Container(
                                  height: Dimensions.h50,
                                  width: Dimensions.w50,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(Dimensions.r12),
                                    gradient: LinearGradient(colors: [
                                      Colors.black.withOpacity(0.6),
                                      AppColors.mainPurple,
                                    ]),
                                  ),
                                  child: IconButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection("cart")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .collection("userCart")
                                            .doc(data["pid"])
                                            .set({
                                          "pid": data["pid"],
                                          "uid": FirebaseAuth
                                              .instance.currentUser!.uid,
                                          "pname": data["pname"],
                                          "price": data["price"],
                                          "qty": 1,
                                        });
                                        Fluttertoast.showToast(
                                            msg:
                                                "Item is added to the cart :)");
                                      },
                                      icon: const Icon(
                                        Icons.shopping_cart_outlined,
                                        color: Colors.white,
                                      ))),
                            ],
                          ),
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: Dimensions.h10),
                          child: Text(
                            "₹.${data["price"]}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
