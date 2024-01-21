import 'package:app/features/authentication/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/global_service.dart';
import 'profile_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/core/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static const String route = '/profile';

  @override
  _ProfilePageState createState() => _ProfilePageState();
  // @override
  // Widget build(BuildContext context) {
  //   return StreamBuilder<User?>(
  //     stream: FirebaseAuth.instance.authStateChanges(),
  //     builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
  //       if (snapshot.connectionState == ConnectionState.active) {
  //         User? user = snapshot.data;
  //         if (user == null) {
  //           return Center(
  //             child: ElevatedButton(
  //               onPressed: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(builder: (context) => const SignInPage()),
  //                 );
  //               },
  //               child: const Text('Go to Login'),
  //             ),
  //           );
  //         } else {
  //           return ChangeNotifierProvider<ProfileViewModel>(
  //             create: (context) => ProfileViewModel(),
  //             child: Scaffold(
  //               appBar: AppBar(
  //                 title: const Text('Profile'),
  //               ),
  //               body: Center(
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     const Text('User Name:'),
  //                     Consumer<ProfileViewModel>(
  //                       builder: (context, viewModel, child) {
  //                         return Text(
  //                           viewModel.userModel?.name ?? 'Loading...',
  //                           style: const TextStyle(fontSize: 24),
  //                         );
  //                       },
  //                     ),
  //                     Builder(
  //                       builder: (context) {
  //                         return ElevatedButton(
  //                           onPressed: () {
  //                             Provider.of<ProfileViewModel>(context,
  //                                     listen: false)
  //                                 .updateUserName('Jane Doe');
  //                           },
  //                           child: const Text('Change Name'),
  //                         );
  //                       },
  //                     ),
  //                     Builder(builder: (context) {
  //                       return ElevatedButton(
  //                         // Add User Button
  //                         onPressed: () {
  //                           UserModel newUser = UserModel(
  //                             id: user.uid,
  //                             name: 'Dummy Name',
  //                             email: 'dummy@email.com',
  //                             program: 'Dummy Program',
  //                             school: 'Dummy School',
  //                             year: 'Dummy Year',
  //                           );
  //                           Provider.of<ProfileViewModel>(context,
  //                                   listen: false)
  //                               .addUser(newUser);
  //                         },
  //                         child: const Text('Add User'),
  //                       );
  //                     }),
  //                     Builder(builder: (context) {
  //                       return ElevatedButton(
  //                         // Delete User Button
  //                         onPressed: () {
  //                           Provider.of<ProfileViewModel>(context,
  //                                   listen: false)
  //                               .deleteUser();
  //                         },
  //                         child: const Text('Delete User'),
  //                       );
  //                     })
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         }
  //       }
  //       return const CircularProgressIndicator(); // Show a progress indicator while waiting
  //     },
  //   );
  // }
}

class _ProfilePageState extends State<ProfilePage> {
  DocumentSnapshot? userData;

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
      body: Column(
        children: [
          Text('Name: ${user!.displayName}'), // Data from FirebaseAuth
          Text('Email: ${user.email}'), // Data from FirebaseAuth
          // Text('Additional Info: ${userData['additional_info']}'), // Data from Firestore
          // ... more user details
        ],
      ),
    );
  }
}

