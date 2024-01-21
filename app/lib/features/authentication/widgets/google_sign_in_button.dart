import 'package:app/features/authentication/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:app/account/utils/authentication.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleSignInButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: Image.asset('assets/google_logo.png', height: 24.0),
      label: const Text('Sign in with Google'),
      onPressed: onPressed,
    );
  }
}
