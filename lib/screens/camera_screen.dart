import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:logger/logger.dart';
import '../screens/videoview_screen.dart';

import '../screens/cameraview_screen.dart';

late List<CameraDescription> cam;

class CameraScreens extends StatefulWidget {
  CameraScreens({Key? key, this.onImageSend, this.response, this.cloudinary})
      : super(key: key);

  final Function? onImageSend;
  CloudinaryResponse? response;
  CloudinaryPublic? cloudinary;
  @override
  _CameraScreensState createState() => _CameraScreensState();
}

class _CameraScreensState extends State<CameraScreens> {
  late CameraController _cameraController;
  String videoPath = '';
  bool isRecording = false;
  bool flash = false;
  bool isCameraFront = true;
  double transform = 0;

  late Future<void> cameravalue;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cam[0], ResolutionPreset.low,
        imageFormatGroup: ImageFormatGroup.yuv420);
    cameravalue = _cameraController.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  void takePhoto(BuildContext context) async {
    var log = Logger();
    await cameravalue;
    String? path =
        join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');
    final image = await _cameraController.takePicture();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) => CameraViewScreen(
                  path: image.path,
                  onImageSend: widget.onImageSend,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        FutureBuilder(
            future: cameravalue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: CameraPreview(_cameraController),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
        Positioned(
          bottom: 0.0,
          child: Container(
            color: Colors.black,
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        icon: Icon(flash ? Icons.flash_on : Icons.flash_off,
                            color: Colors.white, size: 28),
                        onPressed: () {
                          setState(() {
                            flash = !flash;
                          });
                          flash
                              ? _cameraController.setFlashMode(FlashMode.torch)
                              : _cameraController.setFlashMode(FlashMode.off);
                        }),
                    GestureDetector(
                      onLongPress: () async {
                        await _cameraController.startVideoRecording();
                        setState(() {
                          isRecording = true;
                        });
                      },
                      onLongPressUp: () async {
                        final video =
                            await _cameraController.stopVideoRecording();
                        setState(() {
                          isRecording = false;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) =>
                                    VideoViewScreen(videoPath: video.path)));
                      },
                      onTap: () {
                        if (!isRecording) takePhoto(context);
                      },
                      child: isRecording
                          ? const Icon(
                              Icons.radio_button_on,
                              color: Colors.red,
                              size: 70,
                            )
                          : const Icon(
                              Icons.panorama_fish_eye,
                              color: Colors.white,
                              size: 60,
                            ),
                    ),
                    IconButton(
                        icon: const Icon(Icons.flip_camera_ios,
                            color: Colors.white, size: 28),
                        onPressed: () {
                          setState(() {
                            isCameraFront = !isCameraFront;
                            transform = transform + pi;
                          });
                          int cameraPosition = isCameraFront ? 0 : 1;
                          _cameraController = CameraController(
                            cam[cameraPosition],
                            ResolutionPreset.low,
                          );
                          cameravalue = _cameraController.initialize();
                        }),
                  ],
                ),
                const SizedBox(height: 25),
                const Text(
                  'Hold for Video, tap for photo',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
