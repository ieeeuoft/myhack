import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

final double CARD_RADIUS = 20;

class OrderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Container(
      padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
      height: 220,
      width: double.maxFinite,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CARD_RADIUS),
        ),
        child: Stack(children: [
          Container(
            width: 20,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(CARD_RADIUS),
                bottomLeft: Radius.circular(CARD_RADIUS),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Stack(
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            hardwareImage(),
                            SizedBox(
                              height: 10,
                              width: 10,
                            ),
                            hardwareName(),
                            Spacer(),
                            hardwareTime(),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ],
                    ))
              ],
            ),
          )
        ]),
      ),
    )));
  }

  Widget hardwareImage() {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/3/38/Arduino_Uno_-_R3.jpg',
          width: 100, // set the width to 100 pixels
          height: 100, // set the height to 100 pixels
        ),
      ),
    );
  }

  Widget hardwareName() {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          text: "Arduino Uno",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          children: [
            TextSpan(
                text: "\nQty: 1",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget hardwareTime() {
    return Align(
      alignment: Alignment.topRight,
      child: Text(
        "9m ago",
        style: TextStyle(
            color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }
}
