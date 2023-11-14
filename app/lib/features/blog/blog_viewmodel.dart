import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/core/models/blog_model.dart';

class BlogViewModel with ChangeNotifier {
  List<BlogModel> _blogPosts = [];
  List<BlogModel> get blogPosts => _blogPosts;

  BlogModel? _blogPost;
  BlogModel? get blogPost => _blogPost;

  Future<void> fetchAll() async {
    // Fetch all documents from Firestore
    var querySnapshot =
        await FirebaseFirestore.instance.collection('blogPosts').get();
    // Map the documents to BlogModel instances
    _blogPosts = querySnapshot.docs
        .map((doc) => BlogModel.fromDocument(doc.data(), doc.id))
        .toList();
    // Notify listeners that the blog posts have been updated
    notifyListeners();
  }

  Future<void> fetchById(String id) async {
    var doc =
        await FirebaseFirestore.instance.collection('blogPosts').doc(id).get();
    if (doc.exists) {
      _blogPost = BlogModel.fromDocument(doc.data()!, doc.id);
    }
    notifyListeners();
  }

  Future<void> delete(String id) async {
    await FirebaseFirestore.instance.collection('blogPosts').doc(id).delete();
    // Remove the blog post from the list
    _blogPosts.removeWhere((blog) => blog.id == id);
    // Notify listeners that the blog posts have been updated
    notifyListeners();
  }

  Future<void> createBlog(String id, BlogModel blog) async {
    await FirebaseFirestore.instance
        .collection('blogPosts')
        .doc(id)
        .set(blog.toDocument());
    notifyListeners();
  }

  Future<void> updateBlog(String id, String description) async {
    var doc =
        await FirebaseFirestore.instance.collection('blogPosts').doc(id).get();
    if (doc.exists) {
      BlogModel currentBlog = BlogModel.fromDocument(doc.data()!, doc.id);
      BlogModel updatedBlog = BlogModel(
        id: currentBlog.id,
        tags: currentBlog.tags,
        title: currentBlog.title,
        description: description, // update the description
        memberID: currentBlog.memberID,
        createdTime: currentBlog.createdTime,
        updatedTime: Timestamp.now(), // update the updatedTime
        image: currentBlog.image,
      );
      await FirebaseFirestore.instance
          .collection('blogPosts')
          .doc(id)
          .set(updatedBlog.toDocument());
      int indexToUpdate = _blogPosts.indexWhere((blog) => blog.id == id);
      if (indexToUpdate != -1) {
        _blogPosts[indexToUpdate] = updatedBlog;
      }
    }
    notifyListeners();
  }
}