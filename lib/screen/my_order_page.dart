import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kudrati_kahumbo/screen/order_detail_page.dart';
import 'package:kudrati_kahumbo/utils/app_colors.dart';

class MyOrderPage extends StatelessWidget {
  const MyOrderPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainPurple,
          elevation: 5,
          centerTitle: true,
          title: const Text(
            "My Order",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('order')
              .where('cid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data!.docs[index];
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OrderDetailsPage(
                              oid: data['oid'],
                              name: data['cname'],
                              phone: data['phone'],
                              product: data['products'],
                              date: data['date'],
                              hno: data['houseNo'],
                              address: data['address'],
                              area: data['area'],
                              city: data['city'],
                              state: data['state'],
                              pincode: data['pincode'],
                              total: data['total'],
                              orderstatus: data['orderStatus'])));
                    },
                    leading: Image.asset('assets/icons/order.png'),
                    title: Text("${data['oid']}"),
                    subtitle: Text("${data['date']}"),
                    trailing: Text("₹ ${data['total']}"),
                  );
                });
          },
        ));
  }
}
