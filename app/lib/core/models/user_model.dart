class UserModel {
  final String id;
  final String name;
  final String email;

  UserModel({required this.id, required this.name, required this.email});

  // Converts a Firestore Document to a UserModel
  factory UserModel.fromDocument(Map<String, dynamic> doc, String id) {
    return UserModel(
      id: id,
      name: doc['name'],
      email: doc['email'],
    );
  }

  // Converts a UserModel to a Firestore Document
  Map<String, dynamic> toDocument() {
    return {
      'name': name,
      'email': email,
    };
  }
}
