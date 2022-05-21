import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:logger/logger.dart';
import '../screens/camera_screen.dart';
import '../screens/cameraview_screen.dart';

class BottomSheet1 extends StatefulWidget {
  BottomSheet1(
      {Key? key,
      this.xfile1,
      this.imagePicker1,
      this.popTime,
      this.onImageSend1,
      this.response,
      this.cloudinary1})
      : super(key: key);

  ImagePicker? imagePicker1;
  XFile? xfile1;
  CloudinaryResponse? response;
  CloudinaryPublic? cloudinary1;
  Function? onImageSend1;
  int? popTime;

  _BottomSheet1State createState() => _BottomSheet1State();
}

class _BottomSheet1State extends State<BottomSheet1> {
  var log = Logger();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 0.5, vertical: 18),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 1,
            vertical: 20,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.insert_drive_file, Colors.indigo,
                      'Document', () {}),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.camera_alt, Colors.pink, 'Camera', () {
                    setState(() {
                      widget.popTime = 3;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => CameraScreens(
                                  onImageSend: widget.onImageSend1,
                                )));
                  }),
                  const SizedBox(width: 40),
                  iconCreation(Icons.insert_photo, Colors.purple, 'Gallery',
                      () async {
                    setState(() {
                      widget.popTime = 3;
                    });
                    widget.xfile1 = await widget.imagePicker1!
                        .pickImage(source: ImageSource.gallery);

                    log.i(widget.xfile1!.path);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => CameraViewScreen(
                                  path: widget.xfile1!.path,
                                  onImageSend: widget.onImageSend1,
                                )));
                  }),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                    Icons.headset,
                    Colors.orange,
                    'Audio',
                    () {},
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(
                      Icons.location_pin, Colors.teal, 'Location', () {}),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.person, Colors.blue, 'Contact', () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(
      IconData icon, Color color, String text, VoidCallback tapScreen) {
    return InkWell(
        onTap: tapScreen,
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: color,
              child: Icon(icon, size: 29, color: Colors.white),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ));
  }
}
