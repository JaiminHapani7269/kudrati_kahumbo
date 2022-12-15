// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/dimensions.dart';

class CartTile extends StatelessWidget {
  String productName = '';
  var prodcutPrice;
  var qty;
  CartTile({
    Key? key,
    required this.productName,
    required this.prodcutPrice,
    required this.qty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Dimensions.h120,
          width: double.infinity,
          margin: EdgeInsets.all(Dimensions.w15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.r12),
            color: const Color(0xFFECE6E9),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.all(Dimensions.h15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        productName,
                        style: TextStyle(
                          color: AppColors.mainPurple,
                          fontSize: Dimensions.h24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "₹.$prodcutPrice",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimensions.h18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(Dimensions.h10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                        color: AppColors.mainPurple,
                        minWidth: Dimensions.w40,
                        height: Dimensions.h30,
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.h40,
                        width: Dimensions.w120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IncrementDecrement(
                                onPrecced: () {}, icon: Icons.remove_circle),
                            Text(
                              "$qty",
                              style: TextStyle(
                                  fontSize: Dimensions.h24,
                                  fontWeight: FontWeight.bold),
                            ),
                            IncrementDecrement(
                                onPrecced: () {}, icon: Icons.add_circle),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class IncrementDecrement extends StatelessWidget {
  final Function()? onPrecced;
  final IconData icon;
  const IncrementDecrement({
    Key? key,
    this.onPrecced,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPrecced,
        icon: Icon(icon, size: Dimensions.h30, color: AppColors.mainPurple));
  }
}
