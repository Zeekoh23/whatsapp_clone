import '../models/chat_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/chat_model.dart';
import '../screens/individual_screen.dart';
import '../controllers/individual_controller.dart';

class ChatCard extends StatelessWidget {
  ChatCard(
      {Key? key,
      this.sourcechat,
      this.sendMessage,
      this.sendTyping,
      this.sendImage,
      this.scrollController,
      this.inController})
      : super(key: key);

  final ChatModel? sourcechat;
  final Function? sendMessage;
  final Function? sendTyping;
  final Function? sendImage;
  ScrollController? scrollController;
  IndividualController? inController;

  @override
  Widget build(BuildContext context) {
    final chat = Provider.of<ChatModel>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => IndividualScreen(
                      chatmodel: chat,
                      sourcechat: sourcechat,
                    )));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: SvgPicture.asset(
                chat.isGroup! ? "assets/group.svg" : "assets/person.svg",
                color: Colors.white,
                height: 36,
                width: 36,
              ),
              backgroundColor: Colors.blueGrey,
            ),
            title: Text(
              chat.name!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                const Icon(Icons.done_all),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  chat.currentMessage!,
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            trailing: Text(chat.time!),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
