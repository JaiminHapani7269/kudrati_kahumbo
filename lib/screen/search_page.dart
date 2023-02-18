// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kudrati_kahumbo/screen/category_product_screen.dart';
import 'package:kudrati_kahumbo/utils/app_colors.dart';
import 'package:kudrati_kahumbo/utils/dimensions.dart';

import 'home_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = "";
  String queryCat = "";
  var result;
  var resultCat;
  //for popular product
  searchFunction(query, searchList) {
    result = searchList.where((ele) {
      return ele["pname"].toLowerCase().contains(query) ||
          ele["pname"].toUpperCase().contains(query) ||
          ele["pname"].contains(query) ||
          ele["pname"].toLowerCase().contains(query) &&
              ele["pname"].contains(query) &&
              ele["pname"].toUpperCase().contains(query);
    }).toList();
    return result;
  }

  //for category
  searchCategoryFunction(queryCat, searchList) {
    resultCat = searchList.where((ele) {
      return ele["cname"].toLowerCase().contains(query) ||
          ele["cname"].toUpperCase().contains(query) ||
          ele["cname"].contains(query) ||
          ele["cname"].toLowerCase().contains(query) &&
              ele["cname"].contains(query) &&
              ele["cname"].toUpperCase().contains(query);
    }).toList();
    return resultCat;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: Dimensions.h20),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(Dimensions.h10),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: Dimensions.h55,
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          query = val;
                          queryCat = val;
                        });
                      },
                      enabled: true,
                      textInputAction: TextInputAction.go,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            Icons.close,
                            color: AppColors.mainPurple,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.mainPurple,
                        ),
                        hintStyle: const TextStyle(color: AppColors.mainPurple),
                        hintText: "Search Here...",
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColors.mainPurple,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(Dimensions.r24),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.r24),
                          borderSide: const BorderSide(
                              color: AppColors.mainPurple,
                              style: BorderStyle.solid,
                              width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.r24),
                          borderSide: const BorderSide(
                              color: AppColors.mainPurple,
                              style: BorderStyle.solid,
                              width: 2.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.h10),
                  queryCat == ""
                      ? Center(
                          child: Text(
                            'Search Here..',
                            style: TextStyle(
                                color: AppColors.mainPurple,
                                fontSize: Dimensions.h18),
                          ),
                        )
                      : SizedBox(
                          height: Dimensions.h100,
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("category")
                                  .orderBy("cid", descending: false)
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                                if (!streamSnapshot.hasData) {
                                  return const Center(
                                      child: CircularProgressIndicator(
                                    color: AppColors.mainPurple,
                                  ));
                                }
                                var varData = searchCategoryFunction(
                                    queryCat, streamSnapshot.data!.docs);
                                return resultCat.isEmpty
                                    ? Center(
                                        child: Text(
                                          "$queryCat is not in categories",
                                          style: TextStyle(
                                              color: AppColors.mainPurple,
                                              fontSize: Dimensions.h18),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: resultCat.length,
                                        itemBuilder: (context, index) {
                                          var data = varData[index];
                                          return Category(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CategoryProductScreen(
                                                                id: data.id,
                                                                collection: data[
                                                                    "cname"])));
                                              },
                                              icon: data["icon"],
                                              cname: data["cname"]);
                                        });
                              }),
                        ),
                  query == ""
                      ? Center(
                          child: Text(
                            '',
                            style: TextStyle(
                                color: AppColors.mainPurple,
                                fontSize: Dimensions.h18),
                          ),
                        )
                      : StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("popular")
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator(
                                color: AppColors.mainPurple,
                              ));
                            }
                            var varData =
                                searchFunction(query, snapshot.data!.docs);
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: Dimensions.w15, right: Dimensions.w15),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: result.length,
                                  itemBuilder: (context, index) {
                                    var data = varData[index];
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Dimensions.h5,
                                          horizontal: Dimensions.w5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFECE6E9),
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.r12),
                                        ),
                                        child: ListTile(
                                          leading: Container(
                                            height: Dimensions.h50,
                                            width: Dimensions.w50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.r12),
                                                image: DecorationImage(
                                                  fit: BoxFit.contain,
                                                  image: NetworkImage(
                                                      data["image"]),
                                                )),
                                          ),
                                          title: Text(
                                            data["pname"],
                                            style: TextStyle(
                                                color: AppColors.mainPurple,
                                                fontSize: Dimensions.h18,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          subtitle: Text(
                                            "₹ ${data["price"]}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: Dimensions.h15),
                                          ),
                                          trailing: Container(
                                            height: Dimensions.h80,
                                            width: Dimensions.w120,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 0),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                    height: Dimensions.h50,
                                                    width: Dimensions.w50,
                                                    child: IconButton(
                                                        onPressed: () {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "wishlist")
                                                              .doc(FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid)
                                                              .collection(
                                                                  "userWishlist")
                                                              .doc(data["pid"])
                                                              .set({
                                                            "pid": data["pid"],
                                                            "uid": FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid,
                                                            "pname":
                                                                data["pname"],
                                                            "price":
                                                                data["price"],
                                                          });
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "Item is added to your Wishlist :)");
                                                        },
                                                        icon: const Icon(
                                                          Icons
                                                              .favorite_border_outlined,
                                                          color: AppColors
                                                              .mainPurple,
                                                        ))),
                                                SizedBox(width: Dimensions.w5),
                                                Container(
                                                    height: Dimensions.h50,
                                                    width: Dimensions.w50,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            Colors.black
                                                                .withOpacity(
                                                                    0.6),
                                                            AppColors
                                                                .mainPurple,
                                                          ]),
                                                    ),
                                                    child: IconButton(
                                                        onPressed: () {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "cart")
                                                              .doc(FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid)
                                                              .collection(
                                                                  "userCart")
                                                              .doc(data["pid"])
                                                              .set({
                                                            "pid": data["pid"],
                                                            "uid": FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid,
                                                            "pname":
                                                                data["pname"],
                                                            "price":
                                                                data["price"],
                                                            "qty": 1,
                                                          });
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "Item is added to the cart :)");
                                                        },
                                                        icon: const Icon(
                                                          Icons
                                                              .shopping_cart_outlined,
                                                          color: Colors.white,
                                                        ))),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            );
                          }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
