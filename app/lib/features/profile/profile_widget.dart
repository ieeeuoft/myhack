import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget(
      {super.key, required this.imagePath, required this.onClicked, required this.isEdit});

  final String imagePath;
  final VoidCallback onClicked;
  final bool isEdit;

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
            onTap: onClicked,
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
          child: Icon(
                isEdit ? Icons.add_a_photo : Icons.edit,
                size: 20,
              ),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: [
        buildImage(imagePath),
        Positioned(
          bottom: 0,
          right: 4,
          child: buildEditIcon(Colors.blue),
        ),
      ]),
    );
  }
}
