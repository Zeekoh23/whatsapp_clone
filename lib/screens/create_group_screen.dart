import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/chat_provider.dart';
import '../widgets/contact_card.dart';

import '../widgets/avatar_card.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({Key? key}) : super(key: key);

  static const routeName = 'creategroup';

  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  @override
  Widget build(BuildContext context) {
    final contacts = Provider.of<ChatProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'New Group',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Add participants',
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 26),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        //combination of different widgets
        children: [
          ListView.builder(
              itemCount: contacts.contacts.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    height: contacts.groups.length > 0 ? 90 : 10,
                  );
                }
                return ChangeNotifierProvider.value(
                    value: contacts.contacts[index - 1],
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          Provider.of<ChatProvider>(context, listen: false)
                              .createGroup(index);
                        });
                      },
                      child: ContactCard(
                        contacts: contacts.contacts[index - 1],
                      ),
                    ));
              }),
          contacts.groups.length > 0
              ? Column(children: [
                  Container(
                      height: 75,
                      color: Colors.white,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: contacts.contacts.length,
                        itemBuilder: (context, index) {
                          if (contacts.contacts[index].select == true) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  Provider.of<ChatProvider>(context,
                                          listen: false)
                                      .removeGroup1(index);
                                });
                              },
                              child: ChangeNotifierProvider.value(
                                value: contacts.contacts[index],
                                child: const AvatarCard(),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      )),
                  const Divider(thickness: 1),
                ])
              : Container(),
        ],
      ),
    );
  }
}
