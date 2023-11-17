import 'package:app/features/notifications/notifications_page.dart';
import 'package:app/features/team/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  String _teamName = 'Your Team Name'; // Initial team name

  TextEditingController _teamNameController = TextEditingController();

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the initial team name
    _teamNameController = TextEditingController(text: _teamName);
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const ProfilePicture(
                    name: 'User 1',
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
                  teamMemberListWidget(),
                  teamMemberListWidget(),
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
                        _teamName = _teamNameController.text;
                        _isEditing = false;
                      });
                    },
                  )
                ],
              )
            : Row(
                children: [
                  Text(
                    _teamName,
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

  Widget teamMemberListWidget() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                20), // Adjust the radius to shape the pill
            color: Colors.blue, // Change the background color as needed
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                    20), // Should match the container's radius
                child: Image.network(
                  "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg",
                  width: 40, // Set the desired width
                  height: 40, // Set the desired height
                  fit: BoxFit
                      .cover, // Adjust the fit as needed (cover, contain, etc.)
                ),
              ),
              const SizedBox(
                  width: 5), // Adjust the spacing between the image and text
              const Text(
                'User 2',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Colors.white, // Adjust the text color
                ),
              ),
              const SizedBox(
                  width: 10), // Adjust the spacing between the image and text
            ],
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
