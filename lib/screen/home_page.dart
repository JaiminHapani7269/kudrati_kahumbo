// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kudrati_kahumbo/screen/category_product_screen.dart';
import 'package:kudrati_kahumbo/screen/product_detail_screen.dart';

import 'package:kudrati_kahumbo/utils/app_colors.dart';
import 'package:kudrati_kahumbo/utils/dimensions.dart';
import 'package:kudrati_kahumbo/widgets/cart.dart';
import 'package:kudrati_kahumbo/widgets/drawer.dart';

import '../model/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("customer")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColors.mainPurple,
        centerTitle: false,
        elevation: 2,
        title: SvgPicture.asset(
          "assets/images/Group.svg",
        ),
        leading: IconButton(
            onPressed: () => scaffoldKey.currentState!.openDrawer(),
            icon: const Icon(CupertinoIcons.square_grid_2x2)),
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
      drawer: CustomDrawer(
        userName: loggedInUser.c_name,
        mobile: loggedInUser.mobile,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: Dimensions.h10),
            CarouselSlider(
                items: [
                  Image.asset("assets/slider/1.jpg"),
                  Image.asset("assets/slider/2.jpg"),
                  Image.asset("assets/slider/3.jpg"),
                  Image.asset("assets/slider/4.jpg"),
                  Image.asset("assets/slider/5.jpg"),
                  Image.asset("assets/slider/6.jpg"),
                  Image.asset("assets/slider/8.jpg"),
                  Image.asset("assets/slider/7.jpg"),
                  Image.asset("assets/slider/9.jpg"),
                  Image.asset("assets/slider/10.jpg"),
                  Image.asset("assets/slider/11.jpg"),
                  Image.asset("assets/slider/12.jpg"),
                  Image.asset("assets/slider/13.jpg"),
                  Image.asset("assets/slider/14.jpg"),
                  Image.asset("assets/slider/15.jpg"),
                  Image.asset("assets/slider/16.jpg"),
                  Image.asset("assets/slider/17.jpg"),
                  Image.asset("assets/slider/18.jpg"),
                  Image.asset("assets/slider/19.jpg"),
                  Image.asset("assets/slider/20.jpg"),
                  Image.asset("assets/slider/21.jpg"),
                  Image.asset("assets/slider/22.jpg"),
                  Image.asset("assets/slider/23.jpg"),
                  Image.asset("assets/slider/24.jpg"),
                  Image.asset("assets/slider/26.jpg"),
                ],
                options: CarouselOptions(
                  height: Dimensions.h200,
                  viewportFraction: 0.5,
                  aspectRatio: 18 / 6,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                )),
            // const SizedBox(height: 10),
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w12),
              child: const Text(
                "Category",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainPurple,
                    fontSize: 24),
              ),
            ),
            SizedBox(height: Dimensions.h10),
            Container(
              height: Dimensions.h100,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("category")
                      .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (!streamSnapshot.hasData) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: AppColors.mainPurple,
                      ));
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Category(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CategoryProductScreen(
                                        id: streamSnapshot.data!.docs[index].id,
                                        collection: streamSnapshot
                                            .data!.docs[index]["cname"])));
                              },
                              icon: streamSnapshot.data!.docs[index]["icon"],
                              cname: streamSnapshot.data!.docs[index]["cname"]);
                        });
                  }),
            ),
            SizedBox(height: Dimensions.h10),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: Dimensions.w12),
              child: Text(
                "Popular Product",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainPurple,
                    fontSize: Dimensions.h24),
              ),
            ),
            SizedBox(height: Dimensions.h10),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("popular")
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: AppColors.mainPurple,
                    ));
                  }
                  return Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.w15, right: Dimensions.w15),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.h5,
                                horizontal: Dimensions.w5),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFECE6E9),
                                borderRadius:
                                    BorderRadius.circular(Dimensions.r12),
                              ),
                              child: ListTile(
                                leading: Container(
                                  height: Dimensions.h50,
                                  width: Dimensions.w50,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(Dimensions.r12),
                                      image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image: NetworkImage(snapshot
                                            .data!.docs[index]["image"]),
                                      )),
                                ),
                                title: Text(
                                  snapshot.data!.docs[index]["pname"],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: AppColors.mainPurple,
                                      fontSize: Dimensions.h25),
                                ),
                                subtitle: Text(
                                    "Rs.${snapshot.data!.docs[index]["price"]}"),
                                trailing: Container(
                                  height: Dimensions.h80,
                                  width: Dimensions.w120,
                                  padding: EdgeInsets.symmetric(horizontal: 0),
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            gradient: LinearGradient(colors: [
                                              Colors.black.withOpacity(0.6),
                                              AppColors.mainPurple
                                                  .withOpacity(0.7),
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
                              ),
                            ),
                          );
                        }),
                  );
                })
          ],
        ),
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String icon;
  final String cname;
  final Function()? onTap;
  const Category({
    Key? key,
    required this.icon,
    required this.cname,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w10),
        child: Container(
          width: Dimensions.w80,
          height: Dimensions.h80,
          padding: EdgeInsets.only(
              left: Dimensions.w5,
              right: Dimensions.w5,
              bottom: Dimensions.h10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFECE6E9),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(Dimensions.r24),
              bottomLeft: Radius.circular(Dimensions.r24),
              topLeft: Radius.circular(Dimensions.r8),
              bottomRight: Radius.circular(Dimensions.r8),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                height: Dimensions.h40,
              ),
              Text(
                cname,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.mainPurple),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
