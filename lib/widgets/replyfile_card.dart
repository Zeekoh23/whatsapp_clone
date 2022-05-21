import 'package:flutter/material.dart';

class ReplyFileCard extends StatelessWidget {
  ReplyFileCard({
    Key? key,
    this.message,
    this.path,
    this.time,
  }) : super(key: key);
  String? message;
  String? path;
  String? time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height / 1.95,
          width: MediaQuery.of(context).size.width / 1.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey[800],
          ),
          child: Card(
            margin: const EdgeInsets.all(3),
            color: Colors.grey[800],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Expanded(child: Image.network(path!, fit: BoxFit.fitHeight)),
                message!.length > 0
                    ? Container(
                        child: Stack(children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 11, top: 5, left: 10, right: 60),
                              child: Text(
                                message!,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 4,
                            right: 10,
                            child: Row(children: [
                              Text(time!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[100],
                                  )),
                            ]),
                          ),
                        ]),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
