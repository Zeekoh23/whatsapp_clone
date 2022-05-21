import 'package:flutter/material.dart';

import '../models/message_model.dart';

class Message with ChangeNotifier {
  List<MessageModel> messagelist = [];
}
