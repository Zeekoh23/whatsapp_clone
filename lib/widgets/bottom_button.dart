import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  BottomButton({Key? key, this.text, this.icon}) : super(key: key);

  String? text;
  IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon!,
          color: Colors.teal,
          size: 24,
        ),
        const SizedBox(width: 25),
        Text(
          text!,
          style: const TextStyle(color: Colors.teal, fontSize: 14.5),
        )
      ],
    );
  }
}
