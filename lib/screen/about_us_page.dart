import 'package:flutter/material.dart';
import 'package:kudrati_kahumbo/utils/app_colors.dart';
import 'package:kudrati_kahumbo/utils/dimensions.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainPurple,
        elevation: 5,
        centerTitle: true,
        title: const Text(
          "About Us",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
        padding: EdgeInsets.all(Dimensions.w20),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                'Kudrati Kahumbo is the fastest-growing beverage brand in India. From one store to ever-growing franchises in every corner of Gujarat we have created a special place in the hearts of the people of Gujarat.',
                style: TextStyle(fontSize: Dimensions.h18),
              ),
            ),
            SizedBox(height: Dimensions.h20),
            Divider(
              height: Dimensions.h15,
              color: AppColors.mainPurple,
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(Dimensions.h10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Image(
                        image: NetworkImage(
                            'https://www.kudratikahumbo.com/wp-content/uploads/2022/01/Chirag.png'),
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Text(
                              'Founder and Director',
                              style: TextStyle(fontSize: Dimensions.h12),
                            ),
                            Text(
                              'CHIRAG HIRAPARA',
                              style: TextStyle(
                                  color: AppColors.mainPurple,
                                  fontSize: Dimensions.h20),
                            ),
                            Text(
                              'chirag@kudratikahumbo.com',
                              style: TextStyle(fontSize: Dimensions.h12),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
            Divider(
              height: Dimensions.h15,
              color: AppColors.mainPurple,
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(Dimensions.h10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Text(
                              'Founder and Director',
                              style: TextStyle(fontSize: Dimensions.h12),
                            ),
                            Text(
                              'RUSHIK DUDHAT',
                              style: TextStyle(
                                  color: AppColors.mainPurple,
                                  fontSize: Dimensions.h20),
                            ),
                            Text(
                              'rushik@kudratikahumbo.com',
                              style: TextStyle(fontSize: Dimensions.h12),
                            ),
                          ],
                        )),
                    const Expanded(
                      child: Image(
                        image: NetworkImage(
                            'https://www.kudratikahumbo.com/wp-content/uploads/2022/01/rushik.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: Dimensions.h15,
              color: AppColors.mainPurple,
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(Dimensions.h10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Image(
                        image: NetworkImage(
                            'https://www.kudratikahumbo.com/wp-content/uploads/2022/01/hiren.png'),
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Text(
                              'Director',
                              style: TextStyle(fontSize: Dimensions.h12),
                            ),
                            Text(
                              'HIREN PATEL',
                              style: TextStyle(
                                  color: AppColors.mainPurple,
                                  fontSize: Dimensions.h20),
                            ),
                            Text(
                              'hiren@kudratikahumbo.com',
                              style: TextStyle(fontSize: Dimensions.h12),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
            Divider(
              height: Dimensions.h15,
              color: AppColors.mainPurple,
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(Dimensions.h10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Text(
                              'Director',
                              style: TextStyle(fontSize: Dimensions.h12),
                            ),
                            Text(
                              'JAYDIP SUTARIYA',
                              style: TextStyle(
                                  color: AppColors.mainPurple,
                                  fontSize: Dimensions.h20),
                            ),
                            Text(
                              'jayhdip@kudratikahumbo.com',
                              style: TextStyle(fontSize: Dimensions.h12),
                            ),
                          ],
                        )),
                    const Expanded(
                      child: Image(
                        image: NetworkImage(
                            'https://www.kudratikahumbo.com/wp-content/uploads/2022/01/jaydip.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: Dimensions.h15,
              color: AppColors.mainPurple,
            ),
          ],
        ),
      ))),
    );
  }
}
