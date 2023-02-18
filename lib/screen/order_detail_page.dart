// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:kudrati_kahumbo/utils/dimensions.dart';

import '../utils/app_colors.dart';

class OrderDetailsPage extends StatelessWidget {
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
      body: SafeArea(
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
                          const Text("Order Id: "),
                          Text(
                            oid,
                            style: TextStyle(
                                color: AppColors.mainPurple,
                                fontSize: Dimensions.h20),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.h5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text("Order Date: "),
                          Text(
                            date,
                            style: TextStyle(
                                color: AppColors.mainPurple,
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
              color: AppColors.mainPurple,
            ),
            Container(
              height: Dimensions.h110,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        style: TextStyle(fontSize: Dimensions.h15),
                      ),
                      Text(
                        name,
                        style: TextStyle(
                            color: AppColors.mainPurple,
                            fontSize: Dimensions.h24),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Mobile No: ",
                        style: TextStyle(fontSize: Dimensions.h15),
                      ),
                      Text(
                        phone,
                        style: TextStyle(
                            color: AppColors.mainPurple,
                            fontSize: Dimensions.h20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.h20),
            Container(
              height: Dimensions.h120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product Information:',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Divider(
                    height: Dimensions.h20,
                    color: AppColors.mainPurple,
                  ),
                  Text(
                    product,
                    style: TextStyle(
                        color: AppColors.mainPurple, fontSize: Dimensions.h20),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.h20),
            Container(
              height: Dimensions.h120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Delivery Information:',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Divider(
                    height: Dimensions.h24,
                    color: AppColors.mainPurple,
                  ),
                  Text(
                    "Deliver To: ",
                    style: TextStyle(fontSize: Dimensions.h15),
                  ),
                  SizedBox(height: Dimensions.h5),
                  Text(
                    "$hno,$address,$area,$city,$state,$pincode",
                    style: TextStyle(
                        color: AppColors.mainPurple, fontSize: Dimensions.h18),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.h20),
            SizedBox(
              width: double.infinity,
              height: Dimensions.h50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainPurple,
                  ),
                  onPressed: () {},
                  child: Text('Treck Order')),
            ),
          ],
        ),
      )),
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
                "₹ $total",
                style: TextStyle(
                    color: AppColors.mainPurple, fontSize: Dimensions.h24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
