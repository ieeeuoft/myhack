import 'package:flutter/material.dart';
import 'package:app/account/utils/authentication.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: Image.asset(
        'assets/google_logo.png', // put your Google logo asset here
        height: 24.0,
      ),
      label: const Text('Sign in with Google'),
      onPressed: () async {

        final userCredential = await Authentication.signInWithGoogle(context: context);

        if (userCredential == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Sign in failed'),
            ),
          );
        }
      },
    );
  }
}

// class GoogleSignInButton extends StatefulWidget {
//   const GoogleSignInButton({super.key});
//
//   @override
//   GoogleSignInButtonState createState() => GoogleSignInButtonState();
// }
//
// class GoogleSignInButtonState extends State<GoogleSignInButton> {
//   bool _isSigningIn = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: _isSigningIn
//           ? const CircularProgressIndicator(
//         valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//       )
//           : OutlinedButton(
//         style: ButtonStyle(
//           backgroundColor: MaterialStateProperty.all(Colors.white),
//           shape: MaterialStateProperty.all(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(40),
//             ),
//           ),
//         ),
//         onPressed: () async {
//           setState(() {
//             _isSigningIn = true;
//           });
//           User? user =
//           await Authentication.signInWithGoogle(context: context);
//
//           setState(() {
//             _isSigningIn = false;
//           });
//
//           if (user != null) {
//             Navigator.of(context).pushReplacement(
//               MaterialPageRoute(
//                 builder: (context) => UserInfoScreen(
//                   user: user,
//                 ),
//               ),
//             );
//           }
//         },
//         child: Padding(
//           padding:const EdgeInsets.fromLTRB(0, 10, 0, 10),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: const [
//               Image(
//                 image: AssetImage("assets/google_logo.png"),
//                 height: 35.0,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 10),
//                 child: Text(
//                   'Sign in with Google',
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.black54,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
