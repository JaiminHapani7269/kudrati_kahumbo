// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:kudrati_kahumbo/provider/cart_provider.dart';
import 'package:kudrati_kahumbo/utils/app_colors.dart';
import 'package:kudrati_kahumbo/utils/dimensions.dart';
import 'package:kudrati_kahumbo/widgets/order_summery.dart';

class CheckoutPage extends StatefulWidget {
  String productList;
  CheckoutPage({
    Key? key,
    required this.productList,
  }) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController hnoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  var random = Random();

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();
    int totalAmount = cartProvider.totalAmount();
    if (cartProvider.getCartList.isEmpty) {
      setState(() {
        totalAmount = 0;
      });
    }
    String oid = '#${random.nextInt(900000) + 100000}';
    final date = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainPurple,
        elevation: 5,
        centerTitle: true,
        title: const Text(
          "Checkout",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(Dimensions.w20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Customer Information:',
                  style: TextStyle(
                      color: AppColors.mainPurple,
                      fontSize: Dimensions.h24,
                      fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.h5, vertical: Dimensions.w10),
                  child: TextFormField(
                    controller: nameController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    onSaved: (newValue) => nameController.text = newValue!,
                    validator: (value) {
                      if (nameController.text.isEmpty) {
                        return "Please Enter Your Name";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Customer Name',
                      labelStyle: TextStyle(
                        color: AppColors.mainPurple,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.h5, vertical: Dimensions.w10),
                  child: TextFormField(
                    controller: phoneController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onSaved: (newValue) => phoneController.text = newValue!,
                    validator: (value) {
                      if (nameController.text.isEmpty) {
                        return "Please Enter Your Number";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Mobile Number',
                      labelStyle: TextStyle(
                        color: AppColors.mainPurple,
                      ),
                    ),
                  ),
                ),
                Text(
                  'Address Information:',
                  style: TextStyle(
                      color: AppColors.mainPurple,
                      fontSize: Dimensions.h24,
                      fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.h5,
                            vertical: Dimensions.w10),
                        child: TextFormField(
                          controller: hnoController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          onSaved: (newValue) => hnoController.text = newValue!,
                          validator: (value) {
                            if (hnoController.text.isEmpty) {
                              return "Please House No.";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'House No.',
                            labelStyle: TextStyle(
                              color: AppColors.mainPurple,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.h5,
                            vertical: Dimensions.w10),
                        child: TextFormField(
                          controller: addressController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.streetAddress,
                          onSaved: (newValue) =>
                              addressController.text = newValue!,
                          validator: (value) {
                            if (addressController.text.isEmpty) {
                              return "Please Enter Adrress";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Address',
                            labelStyle: TextStyle(
                              color: AppColors.mainPurple,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.h5, vertical: Dimensions.w10),
                  child: TextFormField(
                    controller: areaController,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(15),
                    ],
                    keyboardType: TextInputType.text,
                    onSaved: (newValue) => areaController.text = newValue!,
                    validator: (value) {
                      if (areaController.text.isEmpty) {
                        return "Please Enter Your Area Name";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Area Name',
                      labelStyle: TextStyle(
                        color: AppColors.mainPurple,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.h5, vertical: Dimensions.w10),
                  child: TextFormField(
                    controller: cityController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    onSaved: (newValue) => cityController.text = newValue!,
                    validator: (value) {
                      if (cityController.text.isEmpty) {
                        return "Please Enter Your City";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'City',
                      labelStyle: TextStyle(
                        color: AppColors.mainPurple,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.h5,
                            vertical: Dimensions.w10),
                        child: TextFormField(
                          controller: stateController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          onSaved: (newValue) =>
                              stateController.text = newValue!,
                          validator: (value) {
                            if (stateController.text.isEmpty) {
                              return "Please Enter State";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'State',
                            labelStyle: TextStyle(
                              color: AppColors.mainPurple,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.h5,
                            vertical: Dimensions.w10),
                        child: TextFormField(
                          controller: pincodeController,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(6),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onSaved: (newValue) =>
                              pincodeController.text = newValue!,
                          validator: (value) {
                            if (pincodeController.text.isEmpty) {
                              return "Please Enter Pincode";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Pincode',
                            labelStyle: TextStyle(
                              color: AppColors.mainPurple,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Order Summary:',
                  style: TextStyle(
                      color: AppColors.mainPurple,
                      fontSize: Dimensions.h24,
                      fontWeight: FontWeight.w500),
                ),
                const OrderSummary(),
                SizedBox(
                  height: Dimensions.h50,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainPurple,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          FirebaseFirestore.instance
                              .collection("order")
                              .doc(oid)
                              .set({
                            'oid': oid,
                            'cid': FirebaseAuth.instance.currentUser!.uid,
                            'cname': nameController.text,
                            'phone': phoneController.text,
                            'houseNo': hnoController.text,
                            'address': addressController.text,
                            'area': areaController.text,
                            'city': cityController.text,
                            'state': stateController.text,
                            'pincode': pincodeController.text,
                            'products': widget.productList,
                            'total': totalAmount,
                            'date':
                                "${date.day}/${date.month}/${date.year} -- ${date.hour}:${date.minute}",
                            'orderStatus': 'placed',
                          }).whenComplete(() => Navigator.of(context)
                                  .pushReplacementNamed('payment'));
                        }
                      },
                      child: const Text("Order Now")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
    hnoController.dispose();
    addressController.dispose();
    areaController.dispose();
    cityController.dispose();
    stateController.dispose();
    pincodeController.dispose();
  }
}
