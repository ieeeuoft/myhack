import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class OrderViewModel with ChangeNotifier {
  final User? _user = FirebaseAuth.instance.currentUser;
  Future<void> getOrderData(String teamID) async {
    if (_user != null) {
      final orderData = await FirebaseFirestore.instance
          .collection('orders')
          .doc(teamID)
          .get();
    }
  }

  Future<void> editOrderData(
      String teamID, Map<String, dynamic> newData) async {
    if (_user != null) {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(teamID)
          .update(newData);
    }
  }
}
