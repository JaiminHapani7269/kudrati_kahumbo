import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kudrati_kahumbo/model/checkout_model.dart';
import 'package:kudrati_kahumbo/utils/base_checkout_repositry.dart';

class CheckoutRepo extends BaseCheckoutRepositry {
  final FirebaseFirestore _firebaseFirestore;
  CheckoutRepo({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  @override
  Future<void> addCheckout(Checkout checkout) {
    return _firebaseFirestore.collection("checkout").add(checkout.toDocument());
  }
}
