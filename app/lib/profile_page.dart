import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({super.key, required this.user});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DocumentSnapshot? userData;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  fetchUserData() async {
    DocumentSnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user.uid)
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

    return Scaffold(
      body: Column(
        children: [
          Text('Name: ${widget.user.displayName}'), // Data from FirebaseAuth
          Text('Email: ${widget.user.email}'), // Data from FirebaseAuth
          // Text('Additional Info: ${userData['additional_info']}'), // Data from Firestore
          // ... more user details
        ],
      ),
    );
  }
}

// class _ProfilePageState extends StatelessWidget {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: _firestore
//           .collection('users')
//           .doc(_auth.currentUser!.uid)
//           .get(),
//       builder:
//           (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         }
//         if (!snapshot.hasData || !snapshot.data!.exists) {
//           return Center(child: Text('No data available'));
//         }
//         final data = snapshot.data!.data() as Map<String, dynamic>;
//
//         // Customize the UI based on your profile data structure
//         final name = data['name'];
//         final email = data['email'];
//
//         return Scaffold(
//           appBar: AppBar(
//             title: const Text('Profile Page'),
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Name: $name',
//                   style: const TextStyle(fontSize: 20),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'Email: $email',
//                   style: const TextStyle(fontSize: 20),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
