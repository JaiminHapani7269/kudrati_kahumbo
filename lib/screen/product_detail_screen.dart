// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:kudrati_kahumbo/utils/app_colors.dart';
import 'package:kudrati_kahumbo/utils/dimensions.dart';

class ProductDerailScreen extends StatefulWidget {
  final String id;
  const ProductDerailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ProductDerailScreen> createState() => _ProductDerailScreenState();
}

class _ProductDerailScreenState extends State<ProductDerailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: Dimensions.h350,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/jamun.jpg"),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Positioned(
              top: Dimensions.h45,
              left: Dimensions.w20,
              right: Dimensions.w20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: Dimensions.h40,
                    width: Dimensions.w40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.h40 / 2),
                        color: Colors.white),
                    child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        )),
                  ),
                  Container(
                    height: Dimensions.h40,
                    width: Dimensions.w40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.h40 / 2),
                        color: Colors.white),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.black,
                        )),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: Dimensions.h350 - 30,
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.w20,
                    right: Dimensions.w20,
                    top: Dimensions.h20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.r24),
                    color: Colors.white),
                child: Column(
                  children: [
                    Text(
                      "Jamun Shots",
                      style: TextStyle(
                          fontSize: Dimensions.h35,
                          color: AppColors.mainPurple),
                    ),
                    SizedBox(height: Dimensions.h10),
                    Text(
                      "Rs.120",
                      style: TextStyle(
                          fontSize: Dimensions.h25, color: Colors.black),
                    ),
                    SizedBox(height: Dimensions.h10),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Description",
                        style: TextStyle(
                            fontSize: Dimensions.h20,
                            color: AppColors.mainPurple),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: Dimensions.w5,
                            left: Dimensions.w5,
                            top: Dimensions.h10),
                        child: const Text(
                            "Sed ipsum ipsum justo invidunt sea dolore et consetetur, sit diam accusam gubergren rebum lorem. Tempor dolor gubergren dolore dolor, nonumy sit ipsum erat invidunt. At amet dolore justo ea, magna diam clita eos vero voluptua dolores clita eos nonumy, dolor dolores gubergren magna aliquyam stet ea invidunt lorem. Sed sed invidunt tempor et vero sed, dolor ut justo diam diam sed duo. Amet diam justo eirmod sit sanctus. Sit."),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: Container(
        height: Dimensions.h80,
        padding: EdgeInsets.only(
          top: Dimensions.h20,
          bottom: Dimensions.h20,
          left: Dimensions.w20,
          right: Dimensions.w20,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.r24),
                topRight: Radius.circular(Dimensions.r24)),
            color: Colors.grey[350]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: Dimensions.w120,
              height: Dimensions.h50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.r20),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(
                    Icons.remove,
                    color: Colors.black,
                  ),
                  Text(
                    "0",
                    style: TextStyle(fontSize: Dimensions.h20),
                  ),
                  const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Fluttertoast.showToast(msg: "Thank For Purchasing");
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w20),
                height: Dimensions.h50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.r20),
                  color: AppColors.mainPurple,
                ),
                child: Text(
                  "Add To Cart",
                  style:
                      TextStyle(fontSize: Dimensions.h20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
