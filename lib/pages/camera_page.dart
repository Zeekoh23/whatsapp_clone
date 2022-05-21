import 'package:flutter/material.dart';

import '../screens/camera_screen.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({Key? key}) : super(key: key);

  static const routename = '/camera1';

  @override
  Widget build(BuildContext context) {
    return CameraScreens();
  }
}
