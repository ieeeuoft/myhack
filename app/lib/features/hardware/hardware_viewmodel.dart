import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class HardwareViewModel with ChangeNotifier {
  final User? _user = FirebaseAuth.instance.currentUser;
  Future<void> getHardwareStatus(String hardwareID) async {
    if (_user != null) {
      final hardwareStatus = await FirebaseFirestore.instance
          .collection('hardware')
          .doc(hardwareID)
          .get();
    }
  }
}
