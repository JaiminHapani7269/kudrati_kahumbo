import 'package:flutter/material.dart';
import 'package:kudrati_kahumbo/utils/app_colors.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';
import '../utils/dimensions.dart';

class OrderSummary extends StatefulWidget {
  const OrderSummary({super.key});

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();
    int totalAmount = cartProvider.totalAmount();
    if (cartProvider.getCartList.isEmpty) {
      setState(() {
        totalAmount = 0;
      });
    }
    return Column(
      children: [
        ListTile(
          title: Text(
            "Sub Total:",
            style: TextStyle(
              color: Colors.black,
              fontSize: Dimensions.h15,
            ),
          ),
          trailing: Text(
            "₹ $totalAmount",
            style: TextStyle(
              color: Colors.black,
              fontSize: Dimensions.h15,
            ),
          ),
        ),
        ListTile(
          title: Text(
            "Delivery Fee:",
            style: TextStyle(
              color: Colors.black,
              fontSize: Dimensions.h15,
            ),
          ),
          trailing: Text(
            "₹ 0",
            style: TextStyle(
              color: Colors.black,
              fontSize: Dimensions.h15,
            ),
          ),
        ),
        const Divider(
          color: Colors.black,
          height: 2,
        ),
        ListTile(
          title: Text(
            "Total:",
            style: TextStyle(
              color: AppColors.mainPurple,
              fontSize: Dimensions.h20,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: Text(
            "₹ $totalAmount",
            style: TextStyle(
              color: AppColors.mainPurple,
              fontSize: Dimensions.h20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
