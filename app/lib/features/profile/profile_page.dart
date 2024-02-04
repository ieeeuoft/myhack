import 'package:flutter/material.dart';
import '../../app/global_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app/features/profile/profile_widget.dart';
import 'edit_profile.dart';
import 'field_style.dart';

import 'package:firebase_database/firebase_database.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static const String route = '/profile';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DocumentSnapshot? userData;

  void editProfile() async {
    var user = GlobalUserService().currentUser;
    if (user == null) return;

    DocumentSnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    setState(() {
      userData = result;
    });

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => EditProfile(user: result));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchUserData();
    });
  }

  fetchUserData() async {
    var user = GlobalUserService().currentUser;
    if (user == null) return;

    DocumentSnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    setState(() {
      userData = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    var user = GlobalUserService().currentUser;

    return Scaffold(
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
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
            child: Column(
              children: [
                ProfileStyle(
                  icon: const Icon(
                    Icons.account_circle,
                    size: 40,
                  ),
                  text: "Name: ${userData!['name'].toString()}",
                ),
                const Divider(
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 10,
                ),
                ProfileStyle(
                  icon: const Icon(
                    Icons.email,
                    size: 45,
                  ),
                  text: "Email: ${userData!['email'].toString()}",
                ),
                const Divider(
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 10,
                ),
                ProfileStyle(
                  icon: const Icon(
                    Icons.category,
                    size: 45,
                  ),
                  text: "Program: ${userData!['program'].toString()}",
                ),
                const Divider(
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 10,
                ),
                ProfileStyle(
                  icon: const Icon(
                    Icons.school,
                    size: 45,
                  ),
                  text: "School: ${userData!['school'].toString()}",
                ),
                const Divider(
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 10,
                ),
                ProfileStyle(
                  icon: const Icon(
                    Icons.calculate_outlined,
                    size: 45,
                  ),
                  text: "Year: ${userData!['year'].toString()}",
                ),
                const Divider(
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(100, 20, 100, 20),
            child: ElevatedButton(
              onPressed: editProfile,
              child: const Text('Edit'),
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
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
    );
  }
}
