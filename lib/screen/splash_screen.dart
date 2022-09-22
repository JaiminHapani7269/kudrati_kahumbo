import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kudrati_kahumbo/helper/helper_function.dart';
import 'package:kudrati_kahumbo/utils/app_colors.dart';
import 'package:kudrati_kahumbo/utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogIn = false;

  @override
  void initState() {
    super.initState();
    getLoggedInState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(
            context, isLogIn ? "home" : "registration"));
  }

  getLoggedInState() async {
    await HelperFunction.getLoginData().then((logInStatus) {
      setState(() {
        isLogIn = logInStatus!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Dimensions.screenHeight,
        width: Dimensions.screenWidth,
        color: AppColors.mainPurple,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SvgPicture.asset("assets/images/logo-white.svg"),
          ),
        ),
      ),
    );
  }
}
