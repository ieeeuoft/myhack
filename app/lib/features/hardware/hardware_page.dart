import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'hardware_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui' as ui;





class HardwarePage extends StatefulWidget {
  const HardwarePage({Key key = const Key('deafult_key')}) : super(key: key);

   @override
  _HardwarePageState createState() => _HardwarePageState();

}

class _HardwarePageState extends State<HardwarePage> {
  int selectedImageIndex = 0;

  List<String> images = [
    'arduino.jpg',
    'arduino1.png',
    'arduino2.jpg',
  ];

  void selectImage(int index) {
    setState(() {
      selectedImageIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Name placeholder',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Center(
              child: Image.asset(
                './arduino.jpg',
                width: 200,
                height: 200,
              ),
            ),
        Center(
          child: SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemExtent: 100, 
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    selectImage(index);
                  },
                  child: Container( 
                    width: 100, 
                    child: Center( 
                      child: Image.asset(
                        images[index],
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),

            const SizedBox(height: 10),
            const Text(
              'Description:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Description here...',
              style: TextStyle(fontSize: 14.0),
            ),
            const SizedBox(height: 10),
            const Text(
              'Features:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
              RichText(
              text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                    text: '• ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.black, 
                    ),
                  ),
                  TextSpan(
                    text: 'Feature 1...\n',
                    style: DefaultTextStyle.of(context).style, 
                  ),
                  const TextSpan(
                    text: '• ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.black, 
                    ),
                  ),
                  TextSpan(
                    text: 'Feature 2...\n',
                    style: DefaultTextStyle.of(context).style, 
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}


