import 'package:flutter/material.dart';
// import 'package:chatbot_u/screens/splash/splash_screen.dart';
import 'package:chatbot_u/screens/sign_in/sign_in_screen.dart';

import 'routes.dart';
import 'theme.dart';

import 'package:flutter_downloader/flutter_downloader.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterDownloader.initialize(debug: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chatbot Universitario',
      theme: AppTheme.lightTheme(context),
      initialRoute: SignInScreen.routeName,
      routes: routes,
    );
  }
}
