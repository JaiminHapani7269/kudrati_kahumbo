import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String pid;
  final String uid;
  final String pname;
  final int price;
  final int qty;

  CartModel({
    required this.pid,
    required this.uid,
    required this.pname,
    required this.price,
    required this.qty,
  });

  factory CartModel.fromDocument(QueryDocumentSnapshot doc) {
    return CartModel(
        pid: doc['pid'],
        uid: doc['uid'],
        pname: doc['pname'],
        price: doc['price'],
        qty: doc['qty']);
  }
}
