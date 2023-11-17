import 'package:app/features/authentication/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/core/models/user_model.dart';

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
                    MaterialPageRoute(builder: (context) => const SignInPage()),
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
                      Builder(
                        builder: (context) {
                          return ElevatedButton(
                            onPressed: () {
                              Provider.of<ProfileViewModel>(context,
                                      listen: false)
                                  .updateUserName('Jane Doe');
                            },
                            child: const Text('Change Name'),
                          );
                        },
                      ),
                      Builder(builder: (context) {
                        return ElevatedButton(
                          // Add User Button
                          onPressed: () {
                            UserModel newUser = UserModel(
                              id: user.uid,
                              name: 'Dummy Name',
                              email: 'dummy@email.com',
                              program: 'Dummy Program',
                              school: 'Dummy School',
                              year: 'Dummy Year',
                            );
                            Provider.of<ProfileViewModel>(context,
                                    listen: false)
                                .addUser(newUser);
                          },
                          child: const Text('Add User'),
                        );
                      }),
                      Builder(builder: (context) {
                        return ElevatedButton(
                          // Delete User Button
                          onPressed: () {
                            Provider.of<ProfileViewModel>(context,
                                    listen: false)
                                .deleteUser();
                          },
                          child: const Text('Delete User'),
                        );
                      })
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
