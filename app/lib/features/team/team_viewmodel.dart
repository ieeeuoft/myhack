import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TeamViewModel with ChangeNotifier {
  final User? _user = FirebaseAuth.instance.currentUser;

  int? _userTeamID;

  int? get userTeamID => _userTeamID;

  String? _teamName;
  String? get teamName => _teamName;
  Future<void> loadUserData() async {
    try {
      if (_user != null) {
        CollectionReference participantsCollection =
            FirebaseFirestore.instance.collection('participants');

        // Query to filter documents based on memberID
        QuerySnapshot querySnapshot = await participantsCollection
            .where('memberID', isEqualTo: _user?.uid)
            .get();

        // Check if any documents match the query
        if (querySnapshot.docs.isNotEmpty) {
          // Retrieve the first document (assuming memberID is unique)
          DocumentSnapshot participantDocument = querySnapshot.docs.first;

          // Access the data from the document
          Map<String, dynamic> participantData =
              participantDocument.data() as Map<String, dynamic>;

          // Access the 'teamID' field
          _userTeamID = participantData['teamID'];
          print('User team ID: $_userTeamID');
          notifyListeners();
        }
      }
    } catch (error) {
      print('Error loading user data: $error');
    }
  }

  Future<void> loadTeamData() async {
    try {
      if (_user != null && userTeamID != null) {
        final QuerySnapshot teamSnapshot = await FirebaseFirestore.instance
            .collection('teams')
            .where('teamID', isEqualTo: userTeamID)
            .limit(1)
            .get();

        if (teamSnapshot.docs.isNotEmpty) {
          // Assuming teamID is unique, we retrieve the first document
          final DocumentSnapshot teamDocument = teamSnapshot.docs.first;
          Map<String, dynamic> teamData =
              teamDocument.data() as Map<String, dynamic>;

          _teamName = teamData['teamName'];
          print('Team name: $_teamName');
          notifyListeners();
        }
      }
    } catch (error) {
      print('Error loading team data: $error');
    }
  }

  Future<void> updateTeamName(String newTeamName) async {
    try {
      if (_user != null && userTeamID != null) {
        final QuerySnapshot teamSnapshot = await FirebaseFirestore.instance
            .collection('teams')
            .where('teamID', isEqualTo: userTeamID)
            .limit(1)
            .get();

        if (teamSnapshot.docs.isNotEmpty) {
          // Assuming teamID is unique, we retrieve the first document
          final DocumentSnapshot teamDocument = teamSnapshot.docs.first;
          // Update the 'teamName' field
          await teamDocument.reference.update({
            'teamName': newTeamName,
          });

          // Update the local variable as well
          _teamName = newTeamName;
          notifyListeners();

          print('Team name updated successfully: $_teamName');
        } else {
          print('No team found with the specified teamID: $userTeamID');
        }
      }
    } catch (error) {
      print('Error updating team name: $error');
    }
  }

  Future<void> loadUserDataAndTeamData() async {
    await loadUserData();
    await loadTeamData();
  }
}
