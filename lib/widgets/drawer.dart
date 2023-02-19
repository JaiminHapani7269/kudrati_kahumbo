// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kudrati_kahumbo/helper/helper_function.dart';
import 'package:kudrati_kahumbo/utils/app_colors.dart';
import 'package:kudrati_kahumbo/utils/dimensions.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({Key? key, required this.userName, required this.mobile})
      : super(key: key);
  var userName;
  var mobile;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20.0,
      backgroundColor: Colors.transparent,
      child: SafeArea(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.mainPurple,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.w50),
                  bottomRight: Radius.circular(Dimensions.r50),
                ),
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    child: UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimensions.r50),
                          bottomRight: Radius.circular(Dimensions.r50 * 10),
                        ),
                      ),
                      accountName: Text(
                        "${widget.userName}",
                        style: TextStyle(
                            fontSize: Dimensions.h20,
                            color: AppColors.mainPurple,
                            fontWeight: FontWeight.bold),
                      ),
                      accountEmail: Text(
                        "${widget.mobile}",
                        style: TextStyle(
                            fontSize: Dimensions.h12,
                            color: AppColors.mainPurple,
                            fontWeight: FontWeight.bold),
                      ),
                      currentAccountPicture: const CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/profile.jpeg'),
                      ),
                    ),
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.shopping_bag, color: Colors.white),
                    title: Text("My Order",
                        style: TextStyle(
                          fontSize: Dimensions.h20,
                        )),
                    onTap: () {
                      Navigator.of(context).pushNamed('myOrder');
                    },
                    textColor: Colors.white,
                  ),
                  ListTile(
                    leading: const Icon(Icons.favorite, color: Colors.white),
                    title: Text("My Wishlist",
                        style: TextStyle(
                          fontSize: Dimensions.h20,
                        )),
                    onTap: () {
                      Navigator.of(context).pushNamed('wishlist');
                    },
                    textColor: Colors.white,
                  ),
                  // ListTile(
                  //   leading: const Icon(CupertinoIcons.arrow_branch,
                  //       color: Colors.white),
                  //   title: Text("Branches",
                  //       style: TextStyle(
                  //         fontSize: Dimensions.h20,
                  //       )),
                  //   onTap: () {
                  //     Navigator.of(context).pushNamed('branch');
                  //   },
                  //   textColor: Colors.white,
                  // ),
                  ListTile(
                    leading: const Icon(CupertinoIcons.chat_bubble,
                        color: Colors.white),
                    title: Text("Feedback",
                        style: TextStyle(
                          fontSize: Dimensions.h20,
                        )),
                    onTap: () {
                      Navigator.of(context).pushNamed('feedback');
                    },
                    textColor: Colors.white,
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.contact_page, color: Colors.white),
                    title: Text("Contact Us",
                        style: TextStyle(
                          fontSize: Dimensions.h20,
                        )),
                    onTap: () {
                      Navigator.of(context).pushNamed('contactUs');
                    },
                    textColor: Colors.white,
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.info_outline, color: Colors.white),
                    title: Text("About Us",
                        style: TextStyle(
                          fontSize: Dimensions.h20,
                        )),
                    onTap: () {
                      Navigator.of(context).pushNamed('aboutUs');
                    },
                    textColor: Colors.white,
                  ),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app_rounded,
                        color: Colors.white),
                    title: Text("Logout",
                        style: TextStyle(
                          fontSize: Dimensions.h20,
                        )),
                    onTap: () async {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Logout"),
                              content: const Text(
                                  "Are you sure you want to logout?"),
                              actions: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  ),
                                  onPressed: () async {
                                    FirebaseAuth.instance
                                        .signOut()
                                        .whenComplete(() async {
                                      await HelperFunction.saveLogingData(
                                          false);
                                      // ignore: use_build_context_synchronously
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          "registration", (route) => false);
                                    });
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: Dimensions.h10,
              left: Dimensions.w20,
              child: Container(
                alignment: Alignment.topLeft,
                child: SvgPicture.asset(
                  "assets/images/logo-white.svg",
                  width: Dimensions.w180,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
