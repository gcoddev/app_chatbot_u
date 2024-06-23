import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:chatbot_u/screens/init_screen.dart';

class LoginSuccessScreen extends StatelessWidget {
  static String routeName = "/login_success";

  const LoginSuccessScreen({super.key});

  Future<Map<String, dynamic>?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');
    if (userDataString != null) {
      return jsonDecode(userDataString);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtienen los datos
        } else if (snapshot.hasError) {
          return Text("Error al obtener los datos del usuario");
        } else {
          Map<String, dynamic>? userData = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              leading: const SizedBox(),
              title: const Text("Inicio de sesión"),
            ),
            body: Column(
              children: [
                const SizedBox(height: 16),
                Image.asset(
                  "assets/images/success.png",
                  height: MediaQuery.of(context).size.height * 0.4, //40%
                ),
                const SizedBox(height: 16),
                Text(
                  "Bienvenido ${userData != null ? userData['nombres'] + "\n" + userData['paterno'] + " " + userData['materno'] : ''}",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, InitScreen.routeName);
                    },
                    child: const Text("Ir a inicio"),
                  ),
                ),
                const Spacer(),
              ],
            ),
          );
        }
      },
    );
  }
}
