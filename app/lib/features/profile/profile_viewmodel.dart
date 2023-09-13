import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/core/models/user_model.dart';

class ProfileViewModel with ChangeNotifier {
  final User? _user = FirebaseAuth.instance.currentUser;
  UserModel? _userModel;

  ProfileViewModel() {
    _loadUserData();
  }

  UserModel? get userModel => _userModel;

  Future<void> _loadUserData() async {
    if (_user != null) {
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.uid)
          .get();
      _userModel = UserModel.fromDocument(userData.data()!, userData.id);
      notifyListeners();
    }
  }

  Future<void> updateUserName(String newUserName) async {
    if (_user != null) {
      // Update Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.uid)
          .update({'name': newUserName});

      // Update local UserModel
      if (_userModel != null) {
        _userModel = UserModel(
          id: _userModel!.id,
          name: newUserName,
          email: _userModel!.email,
        );
        notifyListeners();
      }
    }
  }
}
