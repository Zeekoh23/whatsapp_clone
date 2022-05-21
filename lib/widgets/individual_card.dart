import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cloudinary_public/cloudinary_public.dart';

import 'package:image_picker/image_picker.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:whatsappclone/screens/cameraview_screen.dart';

import './bottom_sheet.dart';

import '../controllers/type_controller.dart';
import './ownfile_card.dart';

import './replyfile_card.dart';
import './messagecard.dart';
import './reply_card.dart';
import '../controllers/individual_controller.dart';
import '../models/chat_model.dart';

import '../models/message_model.dart';
import '../screens/camera_screen.dart';

import '../pages/camera_page.dart';

class IndividualCard extends StatefulWidget {
  IndividualCard(
      {Key? key,
      this.sourcechat,
      this.chatmodel,
      this.sendMessage,
      this.sendTyping,
      this.sendImage,
      this.typing1,
      this.scrollController,
      this.inController})
      : super(key: key);
  final ChatModel? sourcechat;
  final ChatModel? chatmodel;

  final Function? sendMessage;
  final Function? sendTyping;
  final Function? sendImage;
  ScrollController? scrollController;
  IndividualController? inController;
  int? typing1;
  @override
  _IndividualCardState createState() => _IndividualCardState();
}

class _IndividualCardState extends State<IndividualCard> {
  IO.Socket? socket;

  List<MessageModel> messagelist = [];

  bool show = false;
  FocusNode focus = FocusNode();
  static TextEditingController _textcontroller = TextEditingController();

  TypeController typeControl = TypeController();
  bool sendButton = false;
  ImagePicker imagePicker = ImagePicker();

  XFile? xfile1;
  CloudinaryResponse? response;
  int popUp = 0;
  int typing = 0;

  final cloudinary =
      CloudinaryPublic('isaac-eze', 'ml_default_23', cache: false);

  @override
  void initState() {
    super.initState();

    focus.addListener(() {
      if (focus.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  void _cameraScreen(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CameraPage.routename);
  }

  void _cameraView(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CameraViewScreen.routename);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/whatsapp.png'),
          fit: BoxFit.cover,
        ),
      ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: WillPopScope(
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                    shrinkWrap: true,
                    controller: widget.scrollController,
                    itemCount: widget.inController!.chatMessages.length + 1,
                    itemBuilder: (ctx, i) {
                      var item = widget.inController!.chatMessages;
                      if (i == item.length) {
                        return Container(
                          height: 70,
                        );
                      }
                      if (widget.inController!.chatMessages[i].type ==
                          'source') {
                        if (widget.inController!.chatMessages[i].path != '') {
                          return OwnFileCard(
                              path: widget.inController!.chatMessages[i].path,
                              message:
                                  widget.inController!.chatMessages[i].message,
                              time: widget.inController!.chatMessages[i].time);
                        } else {
                          return MessageCard(
                              message:
                                  widget.inController!.chatMessages[i].message,
                              time: widget.inController!.chatMessages[i].time);
                        }
                      } else {
                        if (widget.inController!.chatMessages[i].path.length >
                            0) {
                          return ReplyFileCard(
                              message:
                                  widget.inController!.chatMessages[i].message,
                              path: widget.inController!.chatMessages[i].path,
                              time: widget.inController!.chatMessages[i].time);
                        } else {
                          return ReplyCard(
                            message:
                                widget.inController!.chatMessages[i].message,
                            time: widget.inController!.chatMessages[i].time,
                          );
                        }
                      }
                    }),
              ),
            ),
            Container(
              height: 70,
              child: Row(children: [
                Expanded(
                  child: Card(
                    margin: const EdgeInsets.only(
                      left: 2,
                      right: 2,
                      bottom: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextFormField(
                      controller: _textcontroller,
                      focusNode: focus,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 1,
                      onChanged: (value) {
                        if (value.length > 0) {
                          setState(() {
                            sendButton = true;
                          });

                          widget.sendTyping!(
                            widget.sourcechat!.name,
                            widget.chatmodel!.name,
                            _textcontroller.text,
                          );
                        } else {
                          setState(() {
                            //widget.typing1 = false;
                            sendButton = false;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        hintStyle: const TextStyle(color: Colors.grey),
                        prefixIcon: IconButton(
                          icon: const Icon(
                            Icons.emoji_emotions,
                          ),
                          onPressed: () {
                            setState(() {
                              show = !show;
                            });
                            focus.unfocus();
                            focus.canRequestFocus = true;
                          },
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                icon: const Icon(Icons.attach_file),
                                onPressed: () {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (builder) => BottomSheet1(
                                            imagePicker1: imagePicker,
                                            xfile1: xfile1,
                                            onImageSend1: widget.sendImage,
                                            popTime: popUp,
                                          ));
                                }),
                            IconButton(
                                icon: const Icon(
                                  Icons.camera_alt,
                                ),
                                onPressed: () {
                                  setState(() {
                                    popUp = 2;
                                  });

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => CameraScreens(
                                                onImageSend: widget.sendImage,
                                              )));
                                }),
                          ],
                        ),
                        contentPadding: const EdgeInsets.all(2),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8,
                    right: 5,
                    left: 2,
                  ),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: const Color(0xFF128C7E),
                    child: IconButton(
                        icon: Icon(
                          sendButton ? Icons.send : Icons.mic,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (sendButton) {
                            widget.scrollController!.animateTo(
                                widget
                                    .scrollController!.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut);

                            widget.sendMessage!(
                                _textcontroller.text.trim(),
                                widget.sourcechat!.name,
                                widget.chatmodel!.name,
                                '');

                            _textcontroller.clear();
                            setState(() {
                              sendButton = false;
                            });
                          }
                        }),
                  ),
                ),
              ]),
            ),
            show ? emojiSelect() : Container(),
          ],
        ),
        onWillPop: () {
          if (show) {
            setState(() {
              show = false;
            });
          } else {
            Navigator.pop(context);
          }
          return Future.value(false);
        },
      ),
    );
  }

  Widget emojiSelect() {
    return SizedBox(
        height: 247,
        child: EmojiPicker(
            onEmojiSelected: (category, emoji) {
              print(emoji);
              setState(() {
                _textcontroller.text = _textcontroller.text + emoji.emoji;
              });
              sendButton ? Icons.send : Icons.mic;
            },
            onBackspacePressed: () {
              _textcontroller.text = _textcontroller.text;
            },
            config: const Config(
                columns: 7,
                emojiSizeMax: 25.0,
                verticalSpacing: 0,
                horizontalSpacing: 0,
                initCategory: Category.RECENT,
                bgColor: Color(0xFFF2F2F2),
                indicatorColor: Color(0xFF075E54),
                iconColor: Colors.grey,
                iconColorSelected: Color(0xFF075E54),
                progressIndicatorColor: Color(0xFF075E54),
                backspaceColor: Color(0xFF075E54),
                skinToneDialogBgColor: Colors.white,
                skinToneIndicatorColor: Colors.grey,
                enableSkinTones: true,
                showRecentsTab: true,
                recentsLimit: 6,
                noRecentsText: "No Recents",
                noRecentsStyle: TextStyle(fontSize: 20, color: Colors.black26),
                tabIndicatorAnimDuration: kTabScrollDuration,
                categoryIcons: CategoryIcons(),
                buttonMode: ButtonMode.MATERIAL)));
  }
}
