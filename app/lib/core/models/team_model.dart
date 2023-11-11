class TeamModel {
  final String teamID;
  final String teamName;
  final List<String> members; // Use List<String> instead of String[]
  final String description;
  final List<String> items; // Use List<String> instead of String[]

  TeamModel({
    required this.teamID,
    required this.teamName,
    required this.members,
    required this.description,
    required this.items,
  });

  // Converts a Firestore Document to a UserModel
  factory TeamModel.fromDocument(Map<String, dynamic> doc, String id) {
    return TeamModel(
      teamID: id,
      teamName: doc['teamName'],
      members: List<String>.from(doc['members']),
      description: doc['description'],
      items: List<String>.from(doc['items']),
    );
  }

  // Converts a TeamModel to a Firestore Document
  Map<String, dynamic> toDocument() {
    return {
      'teamName': teamName,
      'members': members,
      'description': description,
      'items': items,
    };
  }
}
