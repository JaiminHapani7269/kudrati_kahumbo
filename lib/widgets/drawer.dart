import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kudrati_kahumbo/helper/helper_function.dart';
import 'package:kudrati_kahumbo/screen/splash_screen.dart';
import 'package:kudrati_kahumbo/utils/app_colors.dart';
import 'package:kudrati_kahumbo/utils/dimensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({Key? key, required this.userName, required this.mobile})
      : super(key: key) {}
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
                        color: AppColors.mainPurple,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimensions.r50),
                        ),
                      ),
                      accountName: Text("${widget.userName}"),
                      accountEmail: Text("${widget.mobile}"),
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
                    onTap: () {},
                    textColor: Colors.white,
                  ),
                  ListTile(
                    leading: const Icon(Icons.favorite, color: Colors.white),
                    title: Text("My Wishlist",
                        style: TextStyle(
                          fontSize: Dimensions.h20,
                        )),
                    onTap: () {},
                    textColor: Colors.white,
                  ),
                  ListTile(
                    leading: const Icon(CupertinoIcons.list_bullet,
                        color: Colors.white),
                    title: Text("Menu",
                        style: TextStyle(
                          fontSize: Dimensions.h20,
                        )),
                    onTap: () {},
                    textColor: Colors.white,
                  ),
                  ListTile(
                    leading: const Icon(CupertinoIcons.arrow_branch,
                        color: Colors.white),
                    title: Text("Branches",
                        style: TextStyle(
                          fontSize: Dimensions.h20,
                        )),
                    onTap: () {},
                    textColor: Colors.white,
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.shop_2_outlined, color: Colors.white),
                    title: Text("Frenchise",
                        style: TextStyle(
                          fontSize: Dimensions.h20,
                        )),
                    onTap: () {},
                    textColor: Colors.white,
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.contact_page, color: Colors.white),
                    title: Text("Contact Us",
                        style: TextStyle(
                          fontSize: Dimensions.h20,
                        )),
                    onTap: () {},
                    textColor: Colors.white,
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.info_outline, color: Colors.white),
                    title: Text("About Us",
                        style: TextStyle(
                          fontSize: Dimensions.h20,
                        )),
                    onTap: () {},
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
                      FirebaseAuth.instance.signOut().whenComplete(() async {
                        await HelperFunction.saveLogingData(false);
                        Navigator.pushNamedAndRemoveUntil(
                            context, "registration", (route) => false);
                      });
                    },
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
