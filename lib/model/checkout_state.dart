// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:js_util';

import 'package:equatable/equatable.dart';
import 'package:kudrati_kahumbo/model/cart_model.dart';
import 'package:kudrati_kahumbo/model/checkout_model.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object?> get props => [];
}

class CheckoutLoading extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {
  final String? name;
  final String? phone;
  final String? address;
  final String? city;
  final String? country;
  final String? pincode;
  final List<CartModel>? products;
  final String? total;
  final Checkout? checkout;
  CheckoutLoaded({
    this.name,
    this.phone,
    this.address,
    this.city,
    this.country,
    this.pincode,
    this.products,
    this.total,
  }) : checkout = Checkout(
            name: name,
            phone: phone,
            address: address,
            city: city,
            country: country,
            pincode: pincode,
            products: products,
            total: total);

  @override
  List<Object?> get props =>
      [name, phone, address, city, country, pincode, products, total];
}
