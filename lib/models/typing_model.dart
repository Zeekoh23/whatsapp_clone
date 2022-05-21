class TypingModel {
  String message;
  String type;

  TypingModel({
    required this.message,
    required this.type,
  });

  factory TypingModel.fromJson(Map<String, dynamic> json) {
    return TypingModel(message: json['message'], type: json['type']);
  }
}
