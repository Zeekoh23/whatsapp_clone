import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class CameraProvider with ChangeNotifier {
  List<CameraDescription>? cameras;
  var log = Logger();

  void onImageSend(String path) async {
    log.i('hey there working $path');
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://10.0.2.2:5000/chats/upload'));
    request.files.add(await http.MultipartFile.fromPath('imgs', path));
    request.headers.addAll({
      'Content-type': 'multipart/form-data',
    });
    http.StreamedResponse response = await request.send();
    log.i(response.statusCode);
  }
}
