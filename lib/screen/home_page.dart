import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kudrati_kahumbo/utils/app_colors.dart';
import 'package:kudrati_kahumbo/widgets/cart.dart';
import 'package:kudrati_kahumbo/widgets/drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
    List cat = [
      "Fruit Shots",
      "Chocolate Shake",
      "Coffee",
      "Ice Tea",
      "Fruit Juices",
      "Mojito's World",
      "Fruit Layer",
      "Unique Mocktails",
      "Fruit Dish"
    ];
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
            SizedBox(height: 10),
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
                  height: 200,
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
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: const Text(
                "Category",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainPurple,
                    fontSize: 24),
              ),
            ),
            Container(
              height: 110,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: cat.length,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 5),
                        child: Container(
                          width: 80,
                          height: 80,
                          padding: const EdgeInsets.all(12),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: AppColors.mainPurple,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(26),
                              bottomLeft: Radius.circular(26),
                            ),
                            //BoxShadow
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/shot.png",
                                height: 30,
                              ),
                              const SizedBox(height: 3),
                              Text(
                                cat[index],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      )),
            ),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 12),
              child: const Text(
                "Popular Product",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainPurple,
                    fontSize: 24),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    // scrollDirection: Axis.vertical,
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 233, 192, 223),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: const DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image:
                                        AssetImage("assets/images/jamun.jpg"),
                                  )),
                            ),
                            title: const Text(
                              "Jamun Shot",
                              style: TextStyle(
                                  color: AppColors.mainPurple, fontSize: 26),
                            ),
                            subtitle: const Text("Rs.120"),
                            trailing: Container(
                              height: 50,
                              width: 80,
                              decoration: BoxDecoration(
                                color: AppColors.mainPurple,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: const Icon(
                                Icons.add_shopping_cart_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
