import 'package:cloud_firestore/cloud_firestore.dart';

class OrderItemModel {
  final String orderID;
  final String description;
  final String status;
  final DateTime created;
  final DateTime updated;
  final int quantity;
  final String hardwareID;

  OrderItemModel({
    required this.orderID,
    required this.description,
    required this.status,
    required this.created,
    required this.updated,
    required this.quantity,
    required this.hardwareID,
  });

  // Converts a Firestore Document to an OrderItemModel
  factory OrderItemModel.fromDocument(Map<String, dynamic> doc, String id) {
    return OrderItemModel(
      orderID: id,
      description: doc['description'],
      status: doc['status'],
      created: (doc['created'] as Timestamp).toDate(),
      updated: (doc['updated'] as Timestamp).toDate(),
      quantity: doc['quantity'],
      hardwareID: doc['hardwareID'],
    );
  }

  // Converts an OrderItemModel to a Firestore Document
  Map<String, dynamic> toDocument() {
    return {
      'description': description,
      'status': status,
      'created': created,
      'updated': updated,
      'quantity': quantity,
      'hardwareID': hardwareID,
    };
  }
}
