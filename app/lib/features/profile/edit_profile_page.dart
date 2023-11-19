import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.user});
  final User user;

  @override
  State<StatefulWidget> createState() {
    return _EditProfile();
  }
}

class _EditProfile extends State<EditProfile> {
  TextEditingController? userNameController;
  TextEditingController? emailController;

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController(text: widget.user.displayName);
    emailController = TextEditingController(text: widget.user.email);
  }

  void saveData(){
    if (userNameController!.text.trim().isEmpty || emailController!.text.trim().isEmpty) {
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
    widget.user.updateDisplayName(userNameController!.text);
    widget.user.updateEmail(emailController!.text);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    userNameController?.dispose();
    emailController?.dispose();
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
            onClicked: () async {},
            isEdit: true,
          ),
          const SizedBox(height: 30),
          TextField(
            controller: userNameController,
            maxLength: 30,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(label: Text('User Name'),  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
          ),
          const SizedBox(height: 30),
          TextField(
            controller: emailController,
            maxLength: 30,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(label: Text('Email'), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
          ),

          ElevatedButton(
            onPressed: saveData, child: const Text('Save'))
        ],
      ),
    );
  }
}
