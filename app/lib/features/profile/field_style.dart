import 'package:flutter/material.dart';

class ProfileStyle extends StatelessWidget {
  ProfileStyle({super.key, required this.icon, required this.text});

  final Icon icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        icon,
        const SizedBox(
          width: 30,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    ));
  }
}
