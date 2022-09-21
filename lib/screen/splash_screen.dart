import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kudrati_kahumbo/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/helper.dart';

String finalMobile = "";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(
            context, _isSignedIn ? "registration" : "home"));
  }

  getUserLoggedInStatus() async {
    await Helper.getUserLoggedInstatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
