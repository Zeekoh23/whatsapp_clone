import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:logger/logger.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

import 'package:image_picker/image_picker.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../models/typing_model.dart';
import '../controllers/type_controller.dart';

import '../controllers/individual_controller.dart';
import '../models/chat_model.dart';

import '../models/message_model.dart';

import '../widgets/individual_card.dart';

class IndividualScreen extends StatefulWidget {
  IndividualScreen({
    Key? key,
    this.chatmodel,
    this.sourcechat,
  }) : super(key: key);
  ChatModel? chatmodel;
  ChatModel? sourcechat;

  static const routename = "individualscreen";

  @override
  IndividualScreenState createState() => IndividualScreenState();
}

class IndividualScreenState extends State<IndividualScreen> {
  ScrollController _scrollController = ScrollController();
  IO.Socket? socket;

  List<MessageModel> messagelist = [];

  bool show = false;
  FocusNode focus = FocusNode();
  final TextEditingController _textcontroller = TextEditingController();
  IndividualController inController = IndividualController();
  TypeController typeControl = TypeController();
  bool sendButton = false;
  ImagePicker imagePicker = ImagePicker();

  XFile? xfile1;
  CloudinaryResponse? response;
  int popUp = 0;
  int typing = 0;

  int? online;

  ChatModel? target1;

  final cloudinary =
      CloudinaryPublic('isaac-eze', 'ml_default_23', cache: false);

  @override
  void initState() {
    connect();
  }

  void connect() {
    socket = IO.io('http://10.0.2.2:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket!.connect();

    socket!.emit('signin', widget.sourcechat!.name);

    socket!.onConnect((data) {
      socket!.on('online', (userId) {
        print(userId);
      });

      socket!.on('message', (msg) {
        setMessage('destination', msg['message'], msg['path']);
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      });
      socket!.on('typing', (type) {
        handleTyping(
          type['message'],
          'destination',
        );
      });

      socket!.on('connected-user', (data) {
        print(data);
        inController.connectedUser.value = data;
        setState(() {
          online = widget.sourcechat!.id!;
        });
      });
    });

    socket!.on('disconnect', (data) {
      print('${socket!.id} disconnected');
    });
  }

  void sendTyping(String sourceId, String targetId, String message) {
    handleTyping(message, '');

    setState(() {
      typing = 1;
    });

    if (socket!.connected) {
      socket!.emit('typing', {
        'typing': typing,
        'message': message,
        'sourceId': sourceId,
        'targetId': targetId,
      });
    }
  }

  void handleTyping(String message, String type) {
    var typer = {
      'message': message,
      'type': type,
    };

    typeControl.type.add(TypingModel.fromJson(typer));
  }

  void sendSignin(String path1, String path2) {
    handleSignin(path1, path2);
    socket!.emit('online', {'source': path1, 'destination': path2});
  }

  void handleSignin(String path1, String path2) {
    var path = {
      'source': path1,
      'destination': path2,
    };
    inController.chat.add(ChatModel.fromJson(path));
  }

  void sendMessage(
      String message, String sourceId, String targetId, String path) {
    setMessage('source', message, path);
    setState(() {
      typing = 0;
    });
    if (socket!.connected) {
      socket!.emit('message', {
        'message': message,
        'sourceId': sourceId,
        'targetId': targetId,
        'path': path
      });
    }
  }

  void setMessage(String type, String mes, String path) {
    var messageJson = {'message': mes, 'type': type, 'path': path};
    inController.chatMessages.add(MessageModel.fromJson(messageJson));
  }

  var log = Logger();

  void onImageSend(
    String path,
    String message,
  ) async {
    log.i('hey $path');
    log.i(message);
    for (int i = 0; i < popUp; i++) {
      Navigator.pop(context);
    }
    setState(() {
      popUp = 0;
    });

    CloudinaryResponse response = await cloudinary.uploadFile(
      CloudinaryFile.fromFile(path, resourceType: CloudinaryResourceType.Image),
    );

    log.i(response.secureUrl);

    setMessage('source', message, path);
    if (socket!.connected) {
      socket!.emit('message', {
        'message': message,
        'sourceId': widget.sourcechat!.id,
        'targetId': widget.chatmodel!.id,
        'path': response.secureUrl
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            titleSpacing: 0,
            title: InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      child: SvgPicture.asset(
                          widget.chatmodel!.isGroup!
                              ? 'assets/group.svg'
                              : 'assets/person.svg',
                          color: Colors.white,
                          height: 25,
                          width: 25),
                      radius: 20,
                      backgroundColor: Colors.blueGrey,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.chatmodel!.name!,
                            style: const TextStyle(
                              fontSize: 18.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (typing == 1)
                            const Text(
                              'typing',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            )
                          else if (socket!.connected)
                            const Text(
                              'online',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            )
                          else if (!socket!.connected)
                            Text(
                              'Last seen ${DateTime.now().toString().substring(10, 16)}',
                              style: const TextStyle(
                                fontSize: 13,
                              ),
                            )
                        ]),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.videocam),
                onPressed: () {},
              ),
              IconButton(
                  icon: const Icon(
                    Icons.call,
                  ),
                  onPressed: () {}),
              PopupMenuButton<String>(onSelected: (value) {
                print(value);
              }, itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    child: Text('View Contact'),
                    value: 'View Contact',
                  ),
                  const PopupMenuItem(
                    child: Text('Media, links, and docs'),
                    value: 'Media, links, and docs',
                  ),
                  const PopupMenuItem(
                      child: Text('Whatsapp web'), value: 'Whatsapp web'),
                  const PopupMenuItem(
                    child: Text('Search'),
                    value: 'Search',
                  ),
                  const PopupMenuItem(
                    child: Text('Mute Notifications'),
                    value: 'Mute Notifications',
                  ),
                  const PopupMenuItem(
                    child: Text('Wallpaper'),
                    value: 'Wallpaper',
                  ),
                ];
              }),
            ]),
      ),
      body: IndividualCard(
        sourcechat: widget.sourcechat,
        chatmodel: widget.chatmodel,
        sendMessage: sendMessage,
        sendImage: onImageSend,
        sendTyping: sendTyping,
        typing1: typing,
        scrollController: _scrollController,
        inController: inController,
      ),
    );
  }
}
