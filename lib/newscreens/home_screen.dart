import 'package:flutter/material.dart';

import '../models/chat_model.dart';
import '../pages/camera_page.dart';
import '../pages/chat_page.dart';
import '../pages/status_page.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, this.sourchat}) : super(key: key);

  final ChatModel? sourchat;

  static const routename = 'home';

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Whatsapp Clone"),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          PopupMenuButton<String>(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  child: Text("New group"),
                  value: "New group",
                ),
                const PopupMenuItem(
                  child: Text("New broadcast"),
                  value: "New broadcast",
                ),
                const PopupMenuItem(
                  child: Text("Whatsapp Web"),
                  value: "Whatsapp Web",
                ),
                const PopupMenuItem(
                  child: Text("Starred messages"),
                  value: "Starred messages",
                ),
                const PopupMenuItem(
                  child: Text("Settings"),
                  value: "Settings",
                ),
              ];
            },
          ),
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(
              icon: Icon(Icons.camera_alt),
            ),
            Tab(
              text: "CHATS",
            ),
            Tab(
              text: "STATUS",
            ),
            Tab(
              text: "CALLS",
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          const CameraPage(),
          ChatPage(
            sourcechat: widget.sourchat!,
          ),
          StatusPage(),
          const Text("Calls"),
        ],
      ),
    );
  }
}
