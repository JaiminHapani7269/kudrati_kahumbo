import 'package:flutter/material.dart';
import 'package:kudrati_kahumbo/utils/dimensions.dart';

import '../utils/app_colors.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainPurple,
        elevation: 5,
        centerTitle: true,
        title: const Text(
          "Contact Us",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(Dimensions.w20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(Dimensions.w20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 233, 197, 215),
                borderRadius: BorderRadius.circular(Dimensions.r12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'TALK TO SALES',
                    style: TextStyle(
                        color: AppColors.mainPurple, fontSize: Dimensions.h20),
                  ),
                  Divider(
                    height: Dimensions.h10,
                    thickness: 2,
                    color: AppColors.mainPurple,
                  ),
                  SizedBox(height: Dimensions.h20),
                  Text(
                    'Interested in our franchise?',
                    style: TextStyle(fontSize: Dimensions.h15),
                  ),
                  Text(
                    'Just pick up the phone and call us.',
                    style: TextStyle(fontSize: Dimensions.h15),
                  ),
                  SizedBox(height: Dimensions.h20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.phone,
                        color: AppColors.mainPurple,
                      ),
                      Text(
                        '+91-9586110200',
                        style: TextStyle(
                            color: AppColors.mainPurple,
                            fontSize: Dimensions.h20),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: Dimensions.h20),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(Dimensions.w20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 233, 197, 215),
                borderRadius: BorderRadius.circular(Dimensions.r12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'CONTACT SUPPORT',
                    style: TextStyle(
                        color: AppColors.mainPurple, fontSize: Dimensions.h20),
                  ),
                  Divider(
                    height: Dimensions.h10,
                    thickness: 2,
                    color: AppColors.mainPurple,
                  ),
                  SizedBox(height: Dimensions.h20),
                  Text(
                    'Sometimes you need a little help. ',
                    style: TextStyle(fontSize: Dimensions.h15),
                  ),
                  Text(
                    ' Don’t worry, We’re here for you.',
                    style: TextStyle(fontSize: Dimensions.h15),
                  ),
                  SizedBox(height: Dimensions.h20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/whatsapp.png',
                        height: 30,
                      ),
                      Text(
                        ' +91-9586110200',
                        style: TextStyle(
                            color: AppColors.mainPurple,
                            fontSize: Dimensions.h20),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
