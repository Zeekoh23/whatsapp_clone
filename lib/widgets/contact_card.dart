import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/chat_model.dart';

class ContactCard extends StatelessWidget {
  ContactCard({Key? key, this.contacts}) : super(key: key);
  ChatModel? contacts;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 53,
        width: 50,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 23,
              child: SvgPicture.asset(
                'assets/person.svg',
                color: Colors.white,
                height: 30,
                width: 30,
              ),
              backgroundColor: Colors.blueGrey[200],
            ),
            contacts!.select
                ? const Positioned(
                    bottom: 4,
                    right: 5,
                    child: CircleAvatar(
                      backgroundColor: Colors.teal,
                      radius: 11,
                      child: Icon(Icons.check, color: Colors.white, size: 18),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      title: Text(contacts!.name!,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          )),
      subtitle: Text(
        contacts!.status!,
        style: const TextStyle(fontSize: 13),
      ),
    );
  }
}
