import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kudrati_kahumbo/model/user_model.dart';
import 'package:kudrati_kahumbo/screen/auth/regisration_screen.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_colors.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  var pinCode = "";
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 178, 176, 178)),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.mainPurple),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: AppColors.mainPurple,
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.only(left: 25, right: 25, bottom: 15),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/otp.png",
                ),
                const SizedBox(height: 15),
                const Text(
                  "Phone Verification",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(height: 10),
                const Text(
                  "We need to register your phone before getting started !",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  "Your No is ${RegistrationScreen.mobile.substring(0, 3)}*****${RegistrationScreen.mobile.substring(8)} ?",
                  style: const TextStyle(
                      fontSize: 18, color: AppColors.mainPurple),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Pinput(
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsRetrieverApi,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter OTP";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    pinCode = value;
                  },
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                                  verificationId: RegistrationScreen.verify,
                                  smsCode: pinCode);
                          await auth
                              .signInWithCredential(credential)
                              .then((value) async {
                            postDetailsToFirestore();

                            Navigator.pushNamedAndRemoveUntil(
                                context, "home", (route) => false);
                          });
                        } on FirebaseAuthException catch (e) {
                          Fluttertoast.showToast(
                              msg: "Otp Wrong !", textColor: Colors.red);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainPurple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      "Verify Phone Number",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, "registration", (route) => false);
                    },
                    child: const Text(
                      "Edit Phone Number ?",
                      style: TextStyle(color: AppColors.mainPurple),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;
    UserModel userModel = UserModel();
    userModel.mobile = user?.phoneNumber;
    userModel.uid = user?.uid;
    userModel.c_name = RegistrationScreen.username;
    await firebaseFirestore
        .collection("customer")
        .doc(user!.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created succefuly :)");
  }
}
