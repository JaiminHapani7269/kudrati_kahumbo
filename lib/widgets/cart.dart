import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kudrati_kahumbo/utils/dimensions.dart';

import '../utils/app_colors.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainPurple,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Cart",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: ((context, index) {
          return Column(
            children: [
              Container(
                height: Dimensions.h120,
                width: double.infinity,
                margin: EdgeInsets.all(Dimensions.w15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.r12),
                  color: Color(0xFFE8C5D7),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5), blurRadius: 10)
                  ],
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
                              "Product Name",
                              style: TextStyle(
                                color: AppColors.mainPurple,
                                fontSize: Dimensions.h24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "₹.Price",
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
                            Container(
                              height: Dimensions.h40,
                              width: Dimensions.w120,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.remove_circle,
                                          size: Dimensions.h25,
                                          color: AppColors.mainPurple)),
                                  Text(
                                    "1",
                                    style: TextStyle(
                                        fontSize: Dimensions.h18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.add_circle,
                                          size: Dimensions.h25,
                                          color: AppColors.mainPurple)),
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
        }),
      ),
      bottomNavigationBar: SizedBox(
        child: GestureDetector(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.all(Dimensions.h18),
            height: Dimensions.h55,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.mainPurple,
                borderRadius: BorderRadius.circular(Dimensions.r20)),
            child: Center(
              child: Text(
                "Procced To Checkout",
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
    );
  }
}
