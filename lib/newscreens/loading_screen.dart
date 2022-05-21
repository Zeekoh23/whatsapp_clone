import 'package:flutter/material.dart';
import './login_screen.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  void _selectLogin(BuildContext ctx) {
    Navigator.of(ctx).pushReplacementNamed(LoginScreen.routename);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          //safe area works well when there is no appbar
          child: Column(children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Welcome to WhatsApp',
              style: TextStyle(
                color: Colors.teal,
                fontSize: 29,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 13,
            ),
            Image.asset(
              'assets/images/bg.png',
              color: Colors.greenAccent[700],
              height: 340,
              width: 340,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 11.5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: RichText(
                textAlign: TextAlign.center,
                //richtext allows different text and textstyle in its widget
                text: TextSpan(
                  style: const TextStyle(color: Colors.black, fontSize: 17),
                  children: [
                    TextSpan(
                      text: 'Agree and Continue to accept the',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    const TextSpan(
                      text: ' WhatsApp Terms of Service and Privacy Policy',
                      style: TextStyle(
                        color: Colors.cyan,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                _selectLogin(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 110,
                height: 50,
                child: Card(
                  elevation: 8,
                  margin: const EdgeInsets.all(0),
                  color: Colors.greenAccent[700],
                  child: const Center(
                    child: Text(
                      'AGREE AND CONTINUE',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
