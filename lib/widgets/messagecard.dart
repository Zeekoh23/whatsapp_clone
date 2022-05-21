import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  MessageCard({Key? key, this.message, this.time}) : super(key: key);
  final String? message;
  final String? time;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 46,
          ),
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            color: Theme.of(context).primaryColor,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Container(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 11, top: 5, left: 10, right: 75),
                    child: Text(
                      message!,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  // ),
                  Positioned(
                    bottom: 4,
                    right: 10,
                    child: Row(children: [
                      Text(time!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[100],
                          )),
                      Icon(Icons.done_all, size: 20, color: Colors.grey[100]),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
