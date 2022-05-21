import 'package:flutter/material.dart';

import '../widgets/head_status.dart';
import '../widgets/other_status.dart';

class StatusPage extends StatefulWidget {
  StatusPage({Key? key}) : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 48,
            child: FloatingActionButton(
              backgroundColor: Colors.blueGrey[100],
              onPressed: () {},
              elevation: 8,
              child: Icon(
                Icons.edit,
                color: Colors.blueGrey[900],
              ),
            ),
          ),
          const SizedBox(
            height: 13,
          ),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.greenAccent[700],
            elevation: 5,
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          HeadStatus(),
          label('Recent updates'),
          const OtherStatus(
              name: 'Kishor',
              time: '02:35',
              imageName: 'assets/images/2.jpg',
              isSeen: false,
              statusNum: 1),
          const OtherStatus(
            name: 'Dev Stack',
            time: '16:23',
            imageName: 'assets/images/1.jpg',
            isSeen: false,
            statusNum: 3,
          ),
          const OtherStatus(
            name: 'Balram',
            time: '12:40',
            imageName: 'assets/images/3.jpg',
            isSeen: false,
            statusNum: 5,
          ),
          const OtherStatus(
              name: 'Saket',
              time: '19:34',
              imageName: 'assets/images/2.jpg',
              isSeen: false,
              statusNum: 7),
          const SizedBox(
            height: 10,
          ),
          label('Viewed updates'),
          const OtherStatus(
              name: 'Testing1',
              time: '17:55',
              imageName: 'assets/images/4.jpg',
              isSeen: true,
              statusNum: 3),
          const OtherStatus(
            name: 'Saket',
            time: '19:34',
            imageName: 'assets/images/2.jpg',
            isSeen: true,
            statusNum: 5,
          ),
        ]),
      ),
    );
  }

  Widget label(String labelname) {
    return Container(
      height: 33,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 7,
        ),
        child: Text(
          labelname,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
