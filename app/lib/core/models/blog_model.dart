import 'package:cloud_firestore/cloud_firestore.dart';

class BlogModel {
  final String id;
  final List<dynamic> tags;
  final String title;
  final String description;
  final String memberID;
  final Timestamp createdTime;
  final Timestamp updatedTime;
  final String image;

  BlogModel(
      {required this.id,
      required this.tags,
      required this.title,
      required this.description,
      required this.memberID,
      required this.createdTime,
      required this.updatedTime,
      required this.image});

  // Converts a Firestore Document to a UserModel
  factory BlogModel.fromDocument(Map<String, dynamic> doc, String id) {
    return BlogModel(
      id: id,
      tags: doc['tags'],
      title: doc['title'],
      description: doc['description'],
      memberID: doc['memberID'],
      createdTime: doc['createdTime'],
      updatedTime: doc['updatedTime'],
      image: doc['image'],
    );
  }

  // Converts a UserModel to a Firestore Document
  Map<String, dynamic> toDocument() {
    return {// The 'id' field is added here to prevent errors when creating a new post
      'tags': tags,
      'title': title,
      'description': description,
      'memberID': memberID,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'image': image,
    };
  }
}