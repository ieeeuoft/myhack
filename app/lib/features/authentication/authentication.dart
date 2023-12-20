import 'package:app/core/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // return uid
  String _userFromFirebaseUser(User? user){
    return user!.uid;
  }

  // auth change user stream
  Stream<String> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }
  static Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
  
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final OAuthCredential googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
        await _auth.signInWithCredential(googleAuthCredential);

        return userCredential;
      } catch (e) {
        print("Error: $e");  // Handle error appropriately here
        return null;
      }
    }
    return null;
  }
}
