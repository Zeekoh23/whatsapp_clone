import 'package:flutter/foundation.dart';

class ChatModel with ChangeNotifier {
  String? name;
  String? icon;
  bool? isGroup;
  String? time;
  String? currentMessage;
  String? status;
  bool select = false;
  int? id;
  int? typing;
  String? type;

  ChatModel({
    this.name,
    this.icon,
    this.isGroup,
    this.time,
    this.currentMessage,
    this.status,
    this.select = false,
    this.id,
    this.typing,
    this.type,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      typing: json['typing'],
    );
  }
}
