import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/no_account_text.dart';
// import '../../components/socal_card.dart';
import 'components/sign_form.dart';
import 'package:chatbot_u/screens/init_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        SignInScreen.routeName: (context) => SignInScreen(),
        InitScreen.routeName: (context) => InitScreen(),
      },
      home: SignInScreen(),
    );
  }
}

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";

  const SignInScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    // Llama al método para verificar el usuario al inicio
    verifyUser(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Iniciar sesión"),
        automaticallyImplyLeading: false,
      ),
      body: const SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Text(
                    "Bienvenido",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Ingrese su usuario y contraseña\npara ingresar",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  SignForm(),
                  SizedBox(height: 16),
                  SizedBox(height: 20),
                  NoAccountText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void verifyUser(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.containsKey('userData');

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, InitScreen.routeName);
    }
  }
}
