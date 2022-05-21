import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';

import '../widgets/button_card.dart';
import '../widgets/contact_card.dart';

import '../screens/create_group_screen.dart';

class SelectContactScreen extends StatefulWidget {
  const SelectContactScreen({Key? key}) : super(key: key);

  static const routename = 'selectcontact';

  @override
  _SelectContactState createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContactScreen> {
  void _contactGroup(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CreateGroupScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final contacts = Provider.of<ChatProvider>(context, listen: false).contacts;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Select Contact",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "256 contacts",
                style: TextStyle(
                  fontSize: 13,
                ),
              )
            ],
          ),
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.search,
                  size: 26,
                ),
                onPressed: () {}),
            PopupMenuButton<String>(
              padding: const EdgeInsets.all(0),
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (BuildContext contesxt) {
                return [
                  const PopupMenuItem(
                    child: Text("Invite a friend"),
                    value: "Invite a friend",
                  ),
                  const PopupMenuItem(
                    child: Text("Contacts"),
                    value: "Contacts",
                  ),
                  const PopupMenuItem(
                    child: Text("Refresh"),
                    value: "Refresh",
                  ),
                  const PopupMenuItem(
                    child: Text("Help"),
                    value: "Help",
                  ),
                ];
              },
            ),
          ],
        ),
        body: ListView.builder(
            itemCount: contacts.length + 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return InkWell(
                  onTap: () {
                    _contactGroup(context);
                  },
                  child: const ButtonCard(
                    icon: Icons.group,
                    name: "New group",
                  ),
                );
              } else if (index == 1) {
                return const ButtonCard(
                  icon: Icons.person_add,
                  name: "New contact",
                );
              }
              return ContactCard(
                contacts: contacts[index - 2],
              );
            }));
  }
}
