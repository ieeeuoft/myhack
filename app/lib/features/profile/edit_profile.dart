import 'package:app/core/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.user});
  final DocumentSnapshot user;

  @override
  State<StatefulWidget> createState() {
    return _EditProfile();
  }
}

class _EditProfile extends State<EditProfile> {
  TextEditingController? userNameController;
  TextEditingController? emailController;
  TextEditingController? programController;
  TextEditingController? schoolController;
  TextEditingController? yearController;

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController(text: widget.user['name']);
    emailController = TextEditingController(text: widget.user['email']);
    programController = TextEditingController(text: widget.user['program']);
    schoolController = TextEditingController(text: widget.user['school']);
    yearController = TextEditingController(text: widget.user['year']);
  }

  void saveData() {
    if (userNameController!.text.trim().isEmpty ||
        emailController!.text.trim().isEmpty ||
        programController!.text.trim().isEmpty ||
        schoolController!.text.trim().isEmpty ||
        yearController!.text.trim().isEmpty) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid Input'),
                content: const Text('Ensure a valid User Name and Email '),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        //show pop ups on screen
                      },
                      child: const Text('Close'))
                ],
              ));
      return;
    }

    widget.user.reference.update({'name': userNameController!.text});
    widget.user.reference.update({'email': emailController!.text});
    widget.user.reference.update({'school': schoolController!.text});
    widget.user.reference.update({'program': programController!.text});
    widget.user.reference.update({'year': yearController!.text});

    Navigator.pushReplacementNamed(context, '/profile');
    dispose();
  }

  @override
  void dispose() {
    userNameController?.dispose();
    emailController?.dispose();
    schoolController?.dispose();
    programController?.dispose();
    yearController?.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        children: [
          const SizedBox(height: 30),
          ProfileWidget(
            imagePath:
                'https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
            onClicked: (){},
            isEdit: true,
          ),
          const SizedBox(height: 30),
          TextField(
            controller: userNameController,
            maxLength: 30,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                label: Text('User Name'),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
          const SizedBox(height: 30),
          TextField(
            controller: emailController,
            maxLength: 30,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                label: Text('Email'),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
          const SizedBox(height: 30),
          TextField(
            controller: programController,
            maxLength: 30,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                label: Text('Program'),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
          const SizedBox(height: 30),
          TextField(
            controller: schoolController,
            maxLength: 30,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                label: Text('School'),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: yearController,
            maxLength: 30,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                label: Text('Year'),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
          ElevatedButton(onPressed: saveData, child: const Text('Save'))
        ],
      ),
    );
  }
}
