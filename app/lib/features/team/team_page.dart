import 'package:app/features/notifications/notifications_page.dart';
import 'package:app/features/team/order_card.dart';
import 'package:app/features/team/team_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:provider/provider.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  bool _isEditing = false;

  final TeamViewModel _teamViewModel = TeamViewModel();
  late TextEditingController _teamNameController;
  @override
  void initState() {
    super.initState();

    _teamNameController = TextEditingController(text: _teamViewModel.teamName);
  }

  @override
  void dispose() {
    _teamNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const imageUrl =
        "https://t4.ftcdn.net/jpg/02/24/86/95/360_F_224869519_aRaeLneqALfPNBzg0xxMZXghtvBXkfIA.jpg";

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(backgroundColor: Colors.blue),
        body: FutureBuilder<void>(
          future: _teamViewModel.loadUserDataAndTeamData(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ProfilePicture(
                          name: _teamViewModel.currentUserName ?? 'Not loaded',
                          role: 'Team Member',
                          radius: 50,
                          fontsize: 30,
                          tooltip: true,
                          img: imageUrl,
                        ),
                        teamNameWidget()
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Row(
                      children: [
                        for (var name in _teamViewModel.participantNames)
                          teamMemberListWidget(name),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 32.0),
                        child: Text(
                          'Orders',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const NotificationsPage())); //TODO: Change page to Add Order Page
                        },
                      )
                    ],
                  ),
                  const Expanded(child: OrderCard())
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget teamNameWidget() {
    return Container(
        child: _isEditing
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 200,
                    child: TextField(
                        controller: _teamNameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter a team name',
                        )),
                  ),
                  IconButton(
                    icon: const Icon(Icons.save),
                    onPressed: () {
                      setState(() {
                        _isEditing = false;
                      });
                      _teamViewModel.updateTeamName(_teamNameController.text);
                    },
                  )
                ],
              )
            : Row(
                children: [
                  Text(
                    _teamViewModel.teamName ?? 'Not Initialized',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      setState(() {
                        _isEditing = true;
                      });
                    },
                  ),
                ],
              ));
  }

  Widget teamMemberListWidget(String memberName) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue,
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg",
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                memberName,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
