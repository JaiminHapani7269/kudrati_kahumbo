// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:kudrati_kahumbo/model/cart_model.dart';
import 'package:kudrati_kahumbo/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class Checkout extends Equatable {
  final String? name;
  final String? phone;
  final String? address;
  final String? city;
  final String? country;
  final String? pincode;
  final List<CartModel>? products;
  final String? total;
  Checkout({
    this.name,
    this.phone,
    this.address,
    this.city,
    this.country,
    this.pincode,
    this.products,
    this.total,
  });

  @override
  List<Object?> get props =>
      [name, phone, address, city, country, pincode, products, total];
  Map<String, Object> toDocument() {
    Map customerAddress = Map();
    customerAddress['address'] = address;
    customerAddress['city'] = city;
    customerAddress['country'] = country;
    customerAddress['pincode'] = pincode;

    return {
      'customerAddress': customerAddress,
      'Name': name!,
      'Phone': phone!,
      'products': ['jamun shot', 'apple shot'],
      'total': total!,
    };
  }
}
