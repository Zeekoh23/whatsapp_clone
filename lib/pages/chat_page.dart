import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:whatsappclone/providers/chat_provider.dart';

import '../widgets/chat_card.dart';
import '../models/chat_model.dart';
import '../screens/select_contact_screen.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key, this.sourcechat}) : super(key: key);

  final ChatModel? sourcechat;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  void _selectContact(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(SelectContactScreen.routename);
  }

  @override
  Widget build(BuildContext context) {
    final chats = Provider.of<ChatProvider>(context, listen: false).chatmodels;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _selectContact(context);
          },
          child: const Icon(
            Icons.chat,
            color: Colors.white,
          ),
        ),
        body: ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                value: chats[index],
                child: ChatCard(
                  sourcechat: widget.sourcechat,
                ),
              );
            }));
  }
}
