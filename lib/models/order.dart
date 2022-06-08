import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ec_storesneaker/models/product.dart';

class Order {
  String confirmationId;
  Timestamp timestamp;

  List<Product> products;

  Order({
    required this.confirmationId,
    required this.timestamp,
    required this.products,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      confirmationId: map['confirmationId'],
      timestamp: map['timestamp'],
      products: (map['products'] as List<dynamic>)
          .map((product) => Product.fromMap(product))
          .toList(),
    );
  }
}
