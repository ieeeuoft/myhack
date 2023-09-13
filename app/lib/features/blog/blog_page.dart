import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'blog_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Blog Page'),
    );
  }
}
