class UserModel {
  final String id;
  final String name;
  final String email;
  final String program;
  final String school;
  final String year;
  final String profile_url;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.program,
      required this.school,
      required this.year,
      required this.profile_url});

  // Converts a Firestore Document to a UserModel
  factory UserModel.fromDocument(Map<String, dynamic> doc, String id) {
    return UserModel(
      id: id,
      name: doc['name'],
      email: doc['email'],
      program: doc['program'],
      school: doc['school'],
      year: doc['year'],
      profile_url: doc['profile_url'],
    );
  }

  // Converts a UserModel to a Firestore Document
  Map<String, dynamic> toDocument() {
    return {
      'name': name,
      'email': email,
      'program': program,
      'school': school,
      'year': year,
      'profile_url': profile_url,
    };
  }
}
