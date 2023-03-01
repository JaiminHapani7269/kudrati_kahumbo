// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kudrati_kahumbo/screen/search_page.dart';
import 'package:kudrati_kahumbo/widgets/single_product.dart';
import 'package:velocity_x/velocity_x.dart';
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
        elevation: 5,
        title: SvgPicture.asset(
          "assets/images/Group.svg",
        ),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              size: Dimensions.h30,
            )),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                );
              },
              icon: Icon(
                Icons.search_outlined,
                size: Dimensions.h30,
              )),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("wishlist")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("userWishlist")
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('wishlist');
                },
                icon: Icon(
                  Icons.favorite_outline,
                  size: Dimensions.h30,
                ).badge(
                  color: Vx.gray300,
                  size: Dimensions.h15,
                  count: snapshot.data?.docs.length,
                  textStyle: const TextStyle(
                      color: AppColors.mainPurple, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("cart")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("userCart")
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('cart');
                },
                icon: Icon(
                  CupertinoIcons.shopping_cart,
                  size: Dimensions.h30,
                ).badge(
                  color: Vx.gray300,
                  size: Dimensions.h15,
                  count: snapshot.data?.docs.length,
                  textStyle: const TextStyle(
                      color: AppColors.mainPurple, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
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
                  return SingleProductTile(
                    pid: data['pid'],
                    pname: data['pname'],
                    price: data['price'],
                  );
                });
          },
        ),
      ),
    );
  }
}
