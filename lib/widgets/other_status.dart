import 'package:flutter/material.dart';

import './status_painter.dart';

class OtherStatus extends StatelessWidget {
  const OtherStatus(
      {Key? key,
      this.name,
      this.time,
      this.imageName,
      this.isSeen,
      this.statusNum})
      : super(key: key);

  final String? name;
  final String? time;
  final String? imageName;
  final bool? isSeen;
  final int? statusNum;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CustomPaint(
        painter: StatusPainter(isSeen: isSeen, statusNum: statusNum),
        child: CircleAvatar(
          radius: 26,
          backgroundImage: AssetImage(imageName!),
        ),
      ),
      title: Text(
        name!,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      subtitle: Text(
        'Today at, $time',
        style: TextStyle(fontSize: 14, color: Colors.grey[900]),
      ),
    );
  }
}
