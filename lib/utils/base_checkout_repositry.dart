import '../model/checkout_model.dart';

abstract class BaseCheckoutRepositry {
  Future<void> addCheckout(Checkout checkout);
}
