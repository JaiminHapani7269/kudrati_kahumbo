// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kudrati_kahumbo/model/user_model.dart';
import 'package:kudrati_kahumbo/utils/app_colors.dart';
import 'package:kudrati_kahumbo/utils/dimensions.dart';

class OrderDonePage extends StatefulWidget {
  const OrderDonePage({super.key});

  @override
  State<OrderDonePage> createState() => _OrderDonePageState();
}

class _OrderDonePageState extends State<OrderDonePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController feedbackController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  String c_name = '';
  final date = DateTime.now();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("customer")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {
        c_name = loggedInUser.c_name!;
      });
    });
  }

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
                  child: const Text(
                    "Contiune Shopping..",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )),
            ),
            SizedBox(height: Dimensions.h10),
            Container(
              padding: EdgeInsets.all(Dimensions.h12),
              decoration: BoxDecoration(
                color: const Color(0xFFECE6E9),
                borderRadius: BorderRadius.circular(Dimensions.r12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Send Feedback:',
                    // ignore: deprecated_member_use
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.h5, vertical: Dimensions.w10),
                      child: TextFormField(
                        controller: feedbackController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        onSaved: (newValue) =>
                            feedbackController.text = newValue!,
                        validator: (value) {
                          if (feedbackController.text.isEmpty) {
                            return "Please Enter Your Feedback";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Write Here...',
                          hintStyle: const TextStyle(
                            color: AppColors.mainPurple,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Dimensions.r12)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Dimensions.r12)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Dimensions.r12)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainPurple,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            FirebaseFirestore.instance
                                .collection("feedback")
                                .doc()
                                .set({
                              'cname': c_name,
                              'msg': feedbackController.text,
                              'date': "${date.day}/${date.month}/${date.year}",
                            }).whenComplete(() => Navigator.of(context)
                                    .pushReplacementNamed('home'));
                          }
                        },
                        child: const Text('Send Feedback')),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    feedbackController.dispose();
  }
}
