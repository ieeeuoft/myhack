import 'package:app/app/global_service.dart';
import 'package:app/features/authentication/sign_up_page.dart';
import 'package:app/features/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:app/account/resources/custom_colors.dart';
import 'package:app/account/utils/authentication.dart';
import 'package:app/features/authentication/widgets/google_sign_in_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key, this.targetRoute});
  static const String route = '/signin';
  final String? targetRoute;

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  @override
  void initState() {
    super.initState();
    Authentication.initializeFirebase();
  }

  void onSignInSuccess() {
    String route = widget.targetRoute ?? ProfilePage.route;
    Navigator.of(context).pushReplacementNamed(route);
  }

  void handleSignIn() async {
    final user = await Authentication.signInWithGoogle(context: context);
    GlobalUserService().updateUser(user);
    if (user != null) {
      final isRegistered = await Authentication.isUserRegistered(user.uid);
      if (isRegistered) {
        onSignInSuccess();
      } else {
        Navigator.of(context).pushReplacementNamed(SignUpPage.route);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.firebaseNavy,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/firebase_logo.png', height: 160),
              const SizedBox(height: 20),
              const Text(
                'FlutterFire',
                style: TextStyle(color: CustomColors.firebaseYellow, fontSize: 40),
              ),
              const Text(
                'Authentication',
                style: TextStyle(color: CustomColors.firebaseOrange, fontSize: 40),
              ),
              const SizedBox(height: 20),
              GoogleSignInButton(onPressed: handleSignIn),
            ],
          ),
        ),
      ),
    );
  }
}

