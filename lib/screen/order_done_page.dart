import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kudrati_kahumbo/utils/app_colors.dart';
import 'package:kudrati_kahumbo/utils/dimensions.dart';

class OrderDonePage extends StatelessWidget {
  const OrderDonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainPurple,
        elevation: 5,
        centerTitle: true,
        title: const Text(
          "Order Confirm",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(Dimensions.w20),
        child: Column(
          children: [
            Image.asset('assets/images/orderDone.png'),
            SizedBox(height: Dimensions.h10),
            Text(
              'Thank You For Purchase From Kudrati Kahumbo..!',
              style: TextStyle(
                  color: AppColors.mainPurple, fontSize: Dimensions.h24),
            ),
            SizedBox(height: Dimensions.h25),
            SizedBox(
              width: double.infinity,
              height: Dimensions.h50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainPurple,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('home');
                  },
                  child: Text(
                    "Contiune Shopping..",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )),
            ),
          ],
        ),
      )),
    );
  }
}
