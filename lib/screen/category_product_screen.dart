import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/app_colors.dart';
import '../utils/dimensions.dart';
import '../widgets/cart.dart';
import '../widgets/drawer.dart';

class CategoryProductScreen extends StatefulWidget {
  const CategoryProductScreen({super.key});

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
        child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Dimensions.h5, horizontal: Dimensions.w5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFECE6E9),
                    borderRadius: BorderRadius.circular(Dimensions.r12),
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "product");
                    },
                    leading: Container(
                      height: Dimensions.h50,
                      width: Dimensions.w50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.r12),
                          image: const DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: AssetImage("assets/images/choco.jpg"),
                          )),
                    ),
                    title: Text(
                      "Chocolate Shake",
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          color: AppColors.mainPurple,
                          fontSize: Dimensions.h20),
                    ),
                    subtitle: const Text("Rs.240"),
                    trailing: Container(
                      height: Dimensions.h80,
                      width: Dimensions.w120,
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              height: Dimensions.h50,
                              width: Dimensions.w50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(Dimensions.r24),
                              ),
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
                          Container(
                              height: Dimensions.h50,
                              width: Dimensions.w50,
                              decoration: BoxDecoration(
                                color: AppColors.mainPurple,
                                borderRadius:
                                    BorderRadius.circular(Dimensions.r24),
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    Fluttertoast.showToast(
                                        msg: "Item is added to the cart :)");
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
      ),
    );
  }
}
