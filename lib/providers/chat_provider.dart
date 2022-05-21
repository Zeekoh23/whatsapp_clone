import 'package:flutter/material.dart';

import '../models/chat_model.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatmodels = [
    ChatModel(
      name: "Dev Stack",
      isGroup: false,
      currentMessage: "Hi Everyone",
      time: "4:00",
      icon: "person.svg",
      id: 1,
    ),
    ChatModel(
      name: "Kishor",
      isGroup: false,
      currentMessage: "Hi Kishor",
      time: "13:00",
      icon: "person.svg",
      id: 2,
    ),
    ChatModel(
      name: "Collins",
      isGroup: false,
      currentMessage: "Hi Dev Stack",
      time: "8:00",
      icon: "person.svg",
      id: 3,
    ),
    ChatModel(
      name: "Balram Rathore",
      isGroup: false,
      currentMessage: "Hi Dev Stack",
      time: "2:00",
      icon: "person.svg",
      id: 4,
    ),
  ];

  List<ChatModel> contacts = [
    ChatModel(name: "Dev Stack", status: "A full stack developer"),
    ChatModel(name: "Balram", status: "Flutter Developer..........."),
    ChatModel(name: "Saket", status: "Web developer..."),
    ChatModel(name: "Bhanu Dev", status: "App developer...."),
    ChatModel(name: "Collins", status: "Raect developer.."),
    ChatModel(name: "Kishor", status: "Full Stack Web"),
    ChatModel(name: "Testing1", status: "Example work"),
    ChatModel(name: "Testing2", status: "Sharing is caring"),
    ChatModel(name: "Divyanshu", status: "....."),
    ChatModel(name: "Helper", status: "Love you Mom Dad"),
    ChatModel(name: "Tester", status: "I find the bugs"),
  ];
  List<ChatModel> groups = [];

  List<ChatModel> get iContacts {
    return [...contacts];
  }

  List<ChatModel> get items {
    return [...chatmodels];
  }

  void source(int i) {
    chatmodels.removeAt(i);
  }

  void createGroup(int index) {
    if (contacts[index - 1].select == true) {
      groups.remove(contacts[index - 1]);
      contacts[index - 1].select = false;
    } else {
      groups.add(contacts[index - 1]);
      contacts[index - 1].select = true;
    }
  }

  void removeGroup1(int index) {
    groups.remove(contacts[index]);
    contacts[index].select = false;
  }
}
