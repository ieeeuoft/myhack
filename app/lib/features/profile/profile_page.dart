import 'package:flutter/material.dart';
import '../../app/global_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/features/profile/profile_widget.dart';
import 'edit_profile.dart';
import 'field_style.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static const String route = '/profile';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DocumentSnapshot? userData;
  String imageUrl = '';

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

  Future<String?> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putData(await image.readAsBytes());
      final imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('error');
    }
  }

  uploadProfile() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    final url = await uploadImage('Image/', image!);

    var user = GlobalUserService().currentUser;
    if (user == null) return;

    DocumentSnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    setState(() {
      result.reference.update({'profile_url': url});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        ClipOval(
                          child: Material(
                            color: Colors.transparent,
                            child: Ink.image(
                              image:
                                  NetworkImage("${userData!['profile_url']}"),
                              fit: BoxFit.cover,
                              width: 128,
                              height: 128,
                              child: InkWell(
                                onTap: uploadProfile,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 4,
                          child: ClipOval(
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              color: Colors.white,
                              child: ClipOval(
                                child: Container(
                                  color: Colors.blue,
                                  padding: const EdgeInsets.all(10),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 20,
                                    ),
                                    onPressed: uploadProfile,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
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
          ],
        ),
      ),
    );
  }
}
