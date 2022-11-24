// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/app_colors.dart';
import '../utils/dimensions.dart';
import '../widgets/cart.dart';
import '../widgets/drawer.dart';

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
              onPressed: () => scaffoldKey.currentState!.openEndDrawer(),
              icon: const Icon(CupertinoIcons.shopping_cart)),
        ],
      ),
      endDrawer: CartDrawer(),
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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.w10, vertical: Dimensions.h5),
                      decoration: BoxDecoration(
                          color: const Color(0xFFECE6E9),
                          borderRadius: BorderRadius.circular(Dimensions.r12)),
                      child: ListTile(
                        title: Text(
                          snapshot.data!.docs[index]["pname"],
                          style: TextStyle(
                            color: AppColors.mainPurple,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: Container(
                          height: Dimensions.h80,
                          width: Dimensions.w120,
                          padding: EdgeInsets.only(left: 14),
                          child: Row(
                            children: [
                              Container(
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
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(colors: [
                                      Colors.black.withOpacity(0.6),
                                      AppColors.mainPurple.withOpacity(0.7),
                                    ]),
                                  ),
                                  child: IconButton(
                                      onPressed: () {
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
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            "₹${snapshot.data!.docs[index]["price"]}",
                            style: TextStyle(
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
