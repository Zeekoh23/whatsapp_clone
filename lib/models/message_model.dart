class MessageModel {
  String type;
  String message;
  String time;
  String path;

  MessageModel({
    required this.type,
    required this.message,
    required this.time,
    required this.path,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        type: json['type'],
        message: json['message'],
        time: DateTime.now().toString().substring(10, 16),
        path: json['path']);
  }
}
