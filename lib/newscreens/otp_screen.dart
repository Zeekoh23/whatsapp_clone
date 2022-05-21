import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../widgets/bottom_button.dart';
import '../providers/chat_provider.dart';
import '../models/chat_model.dart';
import '../widgets/button_card.dart';
import '../newscreens/home_screen.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({Key? key, this.code, this.number}) : super(key: key);

  final String? number;
  final String? code;

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late ChatModel source;
  @override
  Widget build(BuildContext context) {
    final chats = Provider.of<ChatProvider>(context, listen: false).chatmodels;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.teal[800]),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Verify ${widget.code} ${widget.number}',
          style: TextStyle(color: Colors.teal[800], fontSize: 18.5),
        ),
        actions: [
          PopupMenuButton<String>(
              onSelected: (value) {
                print(value);
              },
              icon: Icon(
                Icons.more_vert,
                color: Colors.teal[800],
              ),
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                      child: Text('New group'), value: 'New group'),
                  const PopupMenuItem(
                    child: Text('New broadcast'),
                    value: 'New broadcast',
                  ),
                  const PopupMenuItem(
                    child: Text('Mute Notifications'),
                    value: 'Mute Notifications',
                  ),
                  const PopupMenuItem(
                    child: Text('Wallpaper'),
                    value: 'Wallpaper',
                  )
                ];
              }),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(
          horizontal: 35,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'We have sent an SMS with a code to ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.5,
                    ),
                  ),
                  TextSpan(
                    text: widget.code! + ' ' + widget.number!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text: ' Wrong number?',
                    style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 14.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            OTPTextField(
                length: 6,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 30,
                style: const TextStyle(
                  fontSize: 17,
                ),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                onCompleted: (pin) {
                  print('Completed: ' + pin);
                }),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Enter 6-digit code',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            BottomButton(text: 'Resend messages', icon: Icons.message),
            const SizedBox(
              height: 12,
            ),
            const Divider(
              thickness: 1.5,
            ),
            BottomButton(
              text: 'Call Me',
              icon: Icons.call,
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (ctx, i) => InkWell(
                  onTap: () {
                    source = chats.removeAt(i);

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (builder) =>
                                HomeScreen(sourchat: source)));
                  },
                  child: ButtonCard(
                    name: chats[i].name,
                    icon: Icons.person,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
