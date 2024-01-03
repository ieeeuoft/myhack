import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TeamViewModel with ChangeNotifier {
  final User? _user = FirebaseAuth.instance.currentUser;

  Future<void> loadTeamData(String teamID) async {
    if (_user != null) {
      // Load team data from Firestore
      final teamData = await FirebaseFirestore.instance
          .collection('teams')
          .doc(teamID)
          .get();

      notifyListeners();
    }
  }

  Future<void> updateTeamName(String teamID, String newTeamName) async {
    if (_user != null) {
      // Update Firestore
      await FirebaseFirestore.instance
          .collection('teams')
          .doc(teamID)
          .update({'teamName': newTeamName});
    }
  }
}
