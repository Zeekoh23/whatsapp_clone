import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/chat_provider.dart';
import '../models/chat_model.dart';
import 'home_screen.dart';
import '../models/country_model.dart';

import '../newscreens/otp_screen.dart';
import '../newscreens/country_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  static const routename = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ChatModel source;

  String countryname = 'India';
  String countrycode = '+91';

  TextEditingController _controller = TextEditingController();

  void setCountryData(CountryModel countrymodel) {
    setState(() {
      countryname = countrymodel.name;
      countrycode = countrymodel.code;
    });
    Navigator.pop(context);
  }

  Future<void> showMyDialogue() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('We will be verifying your phone number',
                      style: TextStyle(fontSize: 16)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    countrycode + '' + _controller.text,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Is this Ok, or would you like to edit the number?',
                    style: TextStyle(
                      fontSize: 15.5,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Edit'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => OtpScreen(
                                code: countrycode,
                                number: _controller.text,
                              )));
                },
                child: const Text('Ok'),
              ),
            ],
          );
        });
  }

  Future<void> showMyDialogue1() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text(
              'Incomplete number',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final chats = Provider.of<ChatProvider>(context, listen: false).chatmodels;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Enter your phone number',
            style: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.w700,
              fontSize: 18,
              wordSpacing: 1,
            ),
          ),
          centerTitle: true,
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
                  ];
                }),
          ]),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Whatsapp will send an sms message to verify your number',
              style: TextStyle(
                fontSize: 13.5,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "What's my number?",
              style: TextStyle(fontSize: 12.8, color: Colors.cyan[800]),
            ),
            const SizedBox(
              height: 15,
            ),
            countrycard(),
            const SizedBox(
              height: 15,
            ),
            number(),
            Expanded(
              child: Container(),
            ),
            InkWell(
              onTap: () {
                if (_controller.text.length < 10) {
                  showMyDialogue1();
                } else {
                  showMyDialogue();
                }
              },
              child: Container(
                color: Colors.tealAccent[400],
                height: 40,
                width: 70,
                child: const Center(
                    child: Text(
                  'NEXT',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                )),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget number() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      height: 38,
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => CountryScreen(
                            setCountryData: setCountryData,
                          )));
            },
            child: Container(
              width: 70,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.teal,
                    width: 1.8,
                  ),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Text('+',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    countrycode.substring(1),
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.teal,
                  width: 1.8,
                ),
              ),
            ),
            width: MediaQuery.of(context).size.width / 1.5 - 100,
            child: TextFormField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8),
                    hintText: 'phone number'),
                onFieldSubmitted: (_) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => OtpScreen(
                                code: countrycode,
                                number: _controller.text,
                              )));
                }),
          ),
        ],
      ),
    );
  }

  Widget countrycard() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => CountryScreen(
                      setCountryData: setCountryData,
                    )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        padding: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
            color: Colors.teal,
            width: 1.8,
          )),
        ),
        child: Row(
          children: [
            Expanded(
              //helps you to take the whole width of row
              child: Container(
                child: Center(
                  child: Text(
                    countryname,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: Colors.teal,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
