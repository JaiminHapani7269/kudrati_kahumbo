import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CartDrawer extends StatefulWidget {
  CartDrawer({Key? key}) : super(key: key) {}

  @override
  State<CartDrawer> createState() => _CartDrawerState();
}

class _CartDrawerState extends State<CartDrawer> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Drawer(
      elevation: 20.0,
      backgroundColor: Colors.transparent,
      child: SafeArea(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.mainPurple,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  bottomLeft: Radius.circular(50.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "Cart Page",
                    style: TextStyle(color: Colors.white, fontSize: 36),
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
