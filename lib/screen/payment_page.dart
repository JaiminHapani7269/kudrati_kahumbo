import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/dimensions.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainPurple,
        elevation: 5,
        centerTitle: true,
        title: const Text(
          "Payment",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: Center(
        child: Image.asset(
          'assets/images/qr_code.jpeg',
          fit: BoxFit.contain,
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.r24),
            topRight: Radius.circular(Dimensions.r24),
          ),
          color: AppColors.mainPurple.withOpacity(0.2),
        ),
        child: SizedBox(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('orderDone');
            },
            child: Container(
              margin: EdgeInsets.all(Dimensions.h18),
              height: Dimensions.h55,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.mainPurple,
                  borderRadius: BorderRadius.circular(Dimensions.r20)),
              child: Center(
                child: Text(
                  "Place Order",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Dimensions.h20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
