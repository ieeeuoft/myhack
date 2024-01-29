import 'package:app/app/app_constants.dart';
import 'package:app/app/global_service.dart';
import 'package:app/features/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app/features/profile/profile_page.dart';

import '../../core/models/user_model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static const String route = '/signup';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String password = '';
  String name = '';
  String school = '';
  String program = '';
  String year = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              onChanged: (value) => name = value.trim(),
              decoration: const InputDecoration(labelText: "Name"),
              validator: (value) => value!.isEmpty ? "Enter your name" : null,
            ),
            TextFormField(
              onChanged: (value) => school = value.trim(),
              decoration: const InputDecoration(labelText: "School"),
              validator: (value) => value!.isEmpty ? "Enter a school" : null,
            ),
            TextFormField(
              onChanged: (value) => program = value.trim(),
              decoration: const InputDecoration(labelText: "Program"),
              validator: (value) => value!.isEmpty ? "Enter an program" : null,
            ),
            TextFormField(
              onChanged: (value) => year = value.trim(),
              decoration: const InputDecoration(labelText: "Year"),
              validator: (value) => value!.isEmpty ? "Enter an year" : null,
            ),
            ElevatedButton(
              child: const Text("Sign Up"),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  signUp();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void signUp() async {
    try {
      var user = GlobalUserService().currentUser;
      assert (user != null);
      UserModel userModel = UserModel(
        id: user!.uid,
        name: name,
        email: user.email!,
        program: program,
        school: school,
        year: year,
      );
      await addUser(user, userModel);
      Fluttertoast.showToast(msg: "Sign Up Successful");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> addUser(User user, UserModel userModel) async {
    String uid = user.uid;

    final userDoc = await FirebaseFirestore.instance
        .collection(AppConstants.userCollection)
        .doc(uid)
        .get();

    if (userDoc.exists) {
      throw Exception('user with ID $uid and Email ${user.email} already exists!');
    }
      await FirebaseFirestore.instance.collection(AppConstants.userCollection)
          .doc(uid)
          .set(userModel.toDocument());
  }
}
