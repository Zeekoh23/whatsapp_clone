import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class EmojiPi extends StatefulWidget {
  const EmojiPi({Key? key, this.controller}) : super(key: key);
  final TextEditingController? controller;
  @override
  _EmojiPiState createState() => _EmojiPiState();
}

class _EmojiPiState extends State<EmojiPi> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 325,
        child: EmojiPicker(
            onEmojiSelected: (category, emoji) {
              print(emoji);
              setState(() {
                widget.controller!.text = widget.controller!.text + emoji.emoji;
              });
            },
            onBackspacePressed: () {},
            config: const Config(
                columns: 7,
                emojiSizeMax: 25.0,
                verticalSpacing: 0,
                horizontalSpacing: 0,
                initCategory: Category.RECENT,
                bgColor: Color(0xFFF2F2F2),
                indicatorColor: Colors.blue,
                iconColor: Colors.grey,
                iconColorSelected: Colors.blue,
                progressIndicatorColor: Colors.blue,
                backspaceColor: Colors.blue,
                skinToneDialogBgColor: Colors.white,
                skinToneIndicatorColor: Colors.grey,
                enableSkinTones: true,
                showRecentsTab: true,
                recentsLimit: 6,
                noRecentsText: "No Recents",
                noRecentsStyle:
                    const TextStyle(fontSize: 20, color: Colors.black26),
                tabIndicatorAnimDuration: kTabScrollDuration,
                categoryIcons: const CategoryIcons(),
                buttonMode: ButtonMode.MATERIAL)));
  }
}
