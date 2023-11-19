import 'package:app/features/authentication/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/core/models/user_model.dart';
import 'package:app/features/profile/profile_widget.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ProfilePage();
  }
}

class _ProfilePage extends State<ProfilePage> {
  void editProfile() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser!;
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => EditProfile(user: user));
  }

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
                  child: ListView(children: [
                    const SizedBox(height: 30),
                    ProfileWidget(
                      imagePath:
                          'https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
                      onClicked: editProfile,
                      isEdit: false,
                    ),
                    const SizedBox(height: 20),
                    Text(user.displayName.toString()),
                    Text(user.email.toString()),

                    ElevatedButton(
                        onPressed: editProfile, child: const Text('Edit'))
                    //Text(user.school.toString()),
                  ]

                      /*mainAxisAlignment: MainAxisAlignment.center,
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
                    ],*/
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
