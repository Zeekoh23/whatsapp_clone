import 'package:flutter/material.dart';

class ReplyCard extends StatelessWidget {
  ReplyCard({Key? key, this.message, this.time, this.typing1})
      : super(key: key);
  final String? message;
  final String? time;
  bool? typing1;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 46,
        ),
        child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            color: Colors.grey[800],
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
            child: Stack(
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 75, top: 5, bottom: 11),
                    child: Text(
                      message!,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    )),
                Positioned(
                  bottom: 4,
                  right: 10,
                  child: Text(
                    time!,
                    style: TextStyle(fontSize: 14, color: Colors.grey[100]),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
