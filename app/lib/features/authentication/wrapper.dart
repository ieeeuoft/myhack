import 'package:app/features/home/home_page.dart';
import 'package:app/features/profile/profile_page.dart';
import 'package:app/features/team/team_page.dart';
import 'package:flutter/material.dart';
import 'package:app/features/authentication/widgets/google_sign_in_button.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  final Widget? child;
  const Wrapper({super.key, this.child});
  @override
  Widget build(BuildContext context) {
    String? user = Provider.of<String?>(context);
    if(user != null)
      return child??Placeholder();
    return Stack(
      children: [
        child??Placeholder(),
        SizedBox.expand(
          child: Container(
              color: Colors.black.withOpacity(0.7),
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 200,
                width : MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(50)
                  ),
                  color: Colors.white,
                ),
                child: const Column(
                  children: [
                    Text("To Access This Page:",style: TextStyle(fontSize: 10),),
                    GoogleSignInButton()
                  ],
                )
              ),
          ),
        ),
      ],
    );
  }
}