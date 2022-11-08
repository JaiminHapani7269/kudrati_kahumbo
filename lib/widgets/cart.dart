import 'package:flutter/material.dart';
import 'package:kudrati_kahumbo/utils/dimensions.dart';

import '../utils/app_colors.dart';

class CartDrawer extends StatefulWidget {
  CartDrawer({Key? key}) : super(key: key) {}

  @override
  State<CartDrawer> createState() => _CartDrawerState();
}

class _CartDrawerState extends State<CartDrawer> {
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
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.mainPurple,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.r50),
                  bottomLeft: Radius.circular(Dimensions.r50),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DrawerHeader(child: Text("Your Cart")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
