import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget(
      {super.key,
      required this.imagePath,
      required this.onClicked,
      required this.isEdit});

  final String imagePath;
  final VoidCallback onClicked;
  final bool isEdit;

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  ImageProvider? profile_image;

  Widget buildImage(imagePath) {
    final image = NetworkImage(imagePath);
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(
            onTap: widget.onClicked,
          ),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => ClipOval(
        child: Container(
          padding: const EdgeInsets.all(2),
          color: Colors.white,
          child: ClipOval(
            child: Container(
              color: Colors.blue,
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                  height: 18,
                  width: 18,
                  child: IconButton(
                    icon: const Icon(
                      Icons.edit,
                      size: 20,
                    ),
                    onPressed: widget.onClicked,
                  )),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: [
        buildImage(widget.imagePath),
        Positioned(
          bottom: 0,
          right: 4,
          child: buildEditIcon(Colors.blue),
        ),
      ]),
    );
  }
}
