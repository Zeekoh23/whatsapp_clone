import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';

import 'newscreens/home_screen.dart';
import './screens/cameraview_screen.dart';
import './screens/select_contact_screen.dart';
import './screens/create_group_screen.dart';
import './screens/individual_screen.dart';
import './providers/chat_provider.dart';
import './screens/camera_screen.dart';

import './newscreens/login_screen.dart';
import './newscreens/country_screen.dart';

import './newscreens/loading_screen.dart';
import './providers/country_provider.dart';
import './pages/camera_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cam = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (c) => ChatProvider(),
        ),
        ChangeNotifierProvider(
          create: (c) => CountryProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.

          fontFamily: 'OpenSans',
          primaryColor: const Color(0xFF075E54),
          accentColor: const Color(0xFF128C7E),
        ),
        routes: {
          SelectContactScreen.routename: (ctx) => const SelectContactScreen(),
          CreateGroupScreen.routeName: (ctx) => const CreateGroupScreen(),
          IndividualScreen.routename: (ctx) => IndividualScreen(),
          HomeScreen.routename: (ctx) => HomeScreen(),
          LoginScreen.routename: (ctx) => LoginScreen(),
          CountryScreen.routename: (ctx) => CountryScreen(),
          CameraViewScreen.routename: (ctx) => const CameraViewScreen(),
          CameraPage.routename: (ctx) => const CameraPage(),
        },
        home: const LoadingScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
