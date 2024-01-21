import 'package:firebase_auth/firebase_auth.dart';

class GlobalUserService {
  static final GlobalUserService _instance = GlobalUserService._internal();

  factory GlobalUserService() {
    return _instance;
  }

  GlobalUserService._internal();

  User? _currentUser;

  void updateUser(User? user) {
    _currentUser = user;
  }

  User? get currentUser => _currentUser;
}
