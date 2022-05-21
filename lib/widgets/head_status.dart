import 'package:flutter/material.dart';

class HeadStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(children: [
        const CircleAvatar(
            radius: 27,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/images/profile.jpg')),
        Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
            backgroundColor: Colors.greenAccent[700],
            radius: 10,
            child: const Icon(
              Icons.add,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
      ]),
      title: const Text(
        'My Status',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        'Tap to add status update',
        style: TextStyle(fontSize: 13, color: Colors.grey[900]),
      ),
    );
  }
}
