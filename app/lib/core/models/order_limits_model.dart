import 'package:cloud_firestore/cloud_firestore.dart';

class OrderLimitsModel {
  final String id;
  final String hardwareID;
  final String categoryType;
  final int quantity;
  final Timestamp updatedTimestamp;

  OrderLimitsModel({ required this.id, required this.hardwareID, 
    required this.categoryType, required this.quantity, 
    required this.updatedTimestamp});

  factory OrderLimitsModel.fromDocument(Map<String, dynamic> doc, String id) {
    return OrderLimitsModel(
      id: id, 
      hardwareID: doc['category'], 
      categoryType: doc['name'], 
      quantity: doc['modelNumber'], 
      updatedTimestamp: doc['manufacturer'], 
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id, 
      'hardwareID': hardwareID, 
      'categoryType': categoryType, 
      'quantity': quantity, 
      'updatedTimeStamp': updatedTimestamp,
    };
  }
}