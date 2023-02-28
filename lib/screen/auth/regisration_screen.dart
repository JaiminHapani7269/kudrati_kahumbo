// ignore_for_file: unnecessary_string_interpolations

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kudrati_kahumbo/utils/dimensions.dart';

import '../../utils/app_colors.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  static String verify = "";
  static String username = "";
  static String mobile = "";

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController countryCode = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController mobile = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    countryCode.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: Dimensions.h10, horizontal: Dimensions.w20),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/login1.png",
                    ),
                    Text(
                      "Phone Verification",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.h24),
                    ),
                    SizedBox(height: Dimensions.h15),
                    Text(
                      "We need to register your phone before getting started!",
                      style: TextStyle(fontSize: Dimensions.h15),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: Dimensions.h30),
                    Container(
                      height: Dimensions.h55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: AppColors.mainPurple),
                        borderRadius: BorderRadius.circular(Dimensions.r12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(Dimensions.w10),
                        child: TextFormField(
                          controller: userName,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (userName.text.isEmpty) {
                              return "Please Enter Your Name";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            userName.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: "Name"),
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.h10),
                    Container(
                      height: Dimensions.h55,
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: AppColors.mainPurple),
                        borderRadius: BorderRadius.circular(Dimensions.r12),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: Dimensions.w10),
                          SizedBox(
                            width: Dimensions.w40,
                            child: TextFormField(
                              controller: countryCode,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                              onSaved: (newValue) =>
                                  countryCode.text = newValue!,
                            ),
                          ),
                          Text(
                            "|",
                            style: TextStyle(
                                fontSize: Dimensions.h35,
                                color: AppColors.mainPurple,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(width: Dimensions.h10),
                          Expanded(
                            child: TextFormField(
                              controller: mobile,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (userName.text.isEmpty) {
                                  return "Please Enter Your Number";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                mobile.text = value!;
                              },
                              textInputAction: TextInputAction.done,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Mobile Number"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Dimensions.h15),
                    SizedBox(
                      height: Dimensions.h45,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber: "${countryCode.text + mobile.text}",
                              verificationCompleted:
                                  (PhoneAuthCredential credential) {},
                              verificationFailed: (FirebaseAuthException e) {
                                Fluttertoast.showToast(msg: "Auth Failed!");
                              },
                              codeSent: (String verificationId,
                                  int? resendToken) async {
                                Navigator.pushReplacementNamed(context, "otp");
                                Fluttertoast.showToast(msg: "OTP Sent :)");
                                RegistrationScreen.verify = verificationId;
                                RegistrationScreen.username = userName.text;
                                RegistrationScreen.mobile = mobile.text;
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {
                                Fluttertoast.showToast(msg: "Timeout!");
                              },
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainPurple,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.r12)),
                        ),
                        child: Text(
                          "Send The Code",
                          style: TextStyle(fontSize: Dimensions.h15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signInWithPhone() async {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, "otp");
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "${countryCode.text + mobile.text}",
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          Fluttertoast.showToast(msg: "Auth Failed!");
        },
        codeSent: (String verificationId, int? resendToken) async {
          Fluttertoast.showToast(msg: "OTP Sent :)");
          RegistrationScreen.verify = verificationId;
          RegistrationScreen.username = userName.text;
          RegistrationScreen.mobile = mobile.text;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          Fluttertoast.showToast(msg: "Timeout!");
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    countryCode.dispose();
    userName.dispose();
    mobile.dispose();
  }
}
