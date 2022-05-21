import 'package:get/get.dart';

import '../models/chat_model.dart';
import '../models/message_model.dart';

class IndividualController extends GetxController {
  var chatMessages = <MessageModel>[].obs;
  var chat = <ChatModel>[].obs;
  var connectedUser = 0.obs;
  var typing = false.obs;
}
