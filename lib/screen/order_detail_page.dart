// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_unnecessary_containers, deprecated_member_use
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kudrati_kahumbo/model/user_model.dart';

import 'package:kudrati_kahumbo/utils/dimensions.dart';

import '../utils/app_colors.dart';

class OrderDetailsPage extends StatefulWidget {
  OrderDetailsPage({
    Key? key,
    required this.oid,
    required this.name,
    required this.phone,
    required this.product,
    required this.date,
    required this.hno,
    required this.address,
    required this.area,
    required this.city,
    required this.state,
    required this.pincode,
    required this.total,
    required this.orderstatus,
  }) : super(key: key);
  final String oid;
  final String name;
  final String phone;
  final String product;
  final String date;
  final String hno;
  final String address;
  final String area;
  final String city;
  final String state;
  final String pincode;
  var total;
  final String orderstatus;

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
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
          "Order Details",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(Dimensions.w20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Order Id:  ",
                              style: TextStyle(
                                  color: AppColors.mainPurple,
                                  fontSize: Dimensions.h20),
                            ),
                            Text(
                              widget.oid,
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: Dimensions.h20),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.h5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Date: ",
                              style: TextStyle(
                                  color: AppColors.mainPurple,
                                  fontSize: Dimensions.h20),
                            ),
                            Text(
                              widget.date,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Dimensions.h15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/icons/order.png',
                        width: 70,
                        height: 70,
                        fit: BoxFit.contain,
                      )),
                ],
              ),
              SizedBox(height: Dimensions.h15),
              Divider(
                height: Dimensions.h12,
                thickness: 1,
                color: AppColors.mainPurple,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Customer Information:',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Divider(
                      height: Dimensions.h12,
                      color: AppColors.mainPurple,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Name: ",
                          style: TextStyle(
                              color: AppColors.mainPurple,
                              fontSize: Dimensions.h18),
                        ),
                        Text(
                          widget.name,
                          style: TextStyle(
                              color: Colors.green, fontSize: Dimensions.h18),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.h5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Mobile No: ",
                          style: TextStyle(
                              color: AppColors.mainPurple,
                              fontSize: Dimensions.h18),
                        ),
                        Text(
                          widget.phone,
                          style: TextStyle(
                              color: Colors.green, fontSize: Dimensions.h18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h20),
              Divider(
                height: Dimensions.h12,
                thickness: 1,
                color: AppColors.mainPurple,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Product Information:',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Divider(
                      height: Dimensions.h12,
                      thickness: 1,
                      color: AppColors.mainPurple,
                    ),
                    Text(
                      widget.product,
                      style: TextStyle(
                          color: AppColors.mainPurple,
                          fontSize: Dimensions.h20),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h20),
              Divider(
                height: Dimensions.h12,
                thickness: 1,
                color: AppColors.mainPurple,
              ),
              SizedBox(
                height: Dimensions.h120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Delivery Information:',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Divider(
                      height: Dimensions.h12,
                      thickness: 1,
                      color: AppColors.mainPurple,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Deliver To: ",
                          style: TextStyle(
                              color: AppColors.mainPurple,
                              fontSize: Dimensions.h18),
                        ),
                        SizedBox(width: Dimensions.h10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.hno},${widget.address},",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Dimensions.h18),
                            ),
                            Text(
                              "${widget.area},${widget.city},",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Dimensions.h18),
                            ),
                            Text(
                              "${widget.state},${widget.pincode}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Dimensions.h18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h20),
              Container(
                padding: EdgeInsets.all(Dimensions.h5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.r12),
                  border: Border.all(width: 1.5, color: AppColors.mainPurple),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order Status:',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      widget.orderstatus,
                      style: TextStyle(
                          color: Colors.green, fontSize: Dimensions.h20),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  if (widget.orderstatus == 'placed' ||
                      widget.orderstatus == 'Placed' ||
                      widget.orderstatus == 'PLACED') {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Cancel Order"),
                            content: const Text(
                                "Are you sure you want to cancel order?"),
                            actions: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.done,
                                  color: Colors.green,
                                ),
                                onPressed: () async {
                                  FirebaseFirestore.instance
                                      .collection('order')
                                      .doc(widget.oid)
                                      .delete()
                                      .whenComplete(() => Navigator.of(context)
                                          .pushReplacementNamed('home'));
                                },
                              ),
                            ],
                          );
                        });
                  } else {
                    Fluttertoast.showToast(
                        msg: "Can't Cancel Order",
                        toastLength: Toast.LENGTH_SHORT);
                  }
                },
                child: Text(
                  "Cancel Order",
                  style: TextStyle(fontSize: Dimensions.h18),
                ),
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
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.h5,
                            vertical: Dimensions.w10),
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
                                'date':
                                    "${date.day}/${date.month}/${date.year}",
                              }).whenComplete(() => Navigator.of(context)
                                      .pushReplacementNamed('home'));
                            }
                          },
                          child: const Text('Send Feedback')),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h10),
            ],
          ),
        )),
      ),
      bottomNavigationBar: Container(
        height: Dimensions.h80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.r24),
            topRight: Radius.circular(Dimensions.r24),
          ),
          color: AppColors.mainPurple.withOpacity(0.2),
        ),
        child: Padding(
          padding: EdgeInsets.all(Dimensions.h15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Grand Total:",
                style: TextStyle(
                    color: AppColors.mainPurple, fontSize: Dimensions.h24),
              ),
              Text(
                "₹ ${widget.total}",
                style: TextStyle(
                    color: AppColors.mainPurple, fontSize: Dimensions.h24),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    feedbackController.dispose();
  }
}
