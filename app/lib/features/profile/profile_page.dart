import 'package:app/features/authentication/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  );
                },
                child: const Text('Go to Login'),
              ),
            );
          } else {
            return ChangeNotifierProvider<ProfileViewModel>(
              create: (context) => ProfileViewModel(),
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Profile'),
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('User Name:'),
                      Consumer<ProfileViewModel>(
                        builder: (context, viewModel, child) {
                          return Text(
                            viewModel.userModel?.name ?? 'Loading...',
                            style: const TextStyle(fontSize: 24),
                          );
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Provider.of<ProfileViewModel>(context, listen: false)
                              .updateUserName('Jane Doe');
                        },
                        child: const Text('Change Name'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        }
        return const CircularProgressIndicator(); // Show a progress indicator while waiting
      },
    );
  }
}
