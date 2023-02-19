import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kudrati_kahumbo/screen/brach_page.dart';
import 'package:kudrati_kahumbo/utils/app_colors.dart';
import 'package:kudrati_kahumbo/utils/dimensions.dart';

class CityBranch extends StatelessWidget {
  const CityBranch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainPurple,
        elevation: 5,
        centerTitle: true,
        title: const Text(
          "Branches",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Branch_City")
                  .orderBy('City_id')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      return Padding(
                        padding: EdgeInsets.all(Dimensions.h10),
                        child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFECE6E9),
                              borderRadius:
                                  BorderRadius.circular(Dimensions.r12),
                            ),
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => BranchPage(
                                        id: data['City_id'],
                                        collection: data['City_name'])));
                              },
                              leading: Image.asset('assets/icons/rout.png'),
                              title: Text(
                                data['City_name'],
                                style: TextStyle(
                                  color: AppColors.mainPurple,
                                  fontSize: Dimensions.h24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                      );
                    });
              })),
    );
  }
}
