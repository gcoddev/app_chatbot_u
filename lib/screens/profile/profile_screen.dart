import 'dart:convert';

import 'package:flutter/material.dart';

import 'components/profile_menu.dart';
import 'components/profile_pic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chatbot_u/screens/sign_in/sign_in_screen.dart';

class UserData {
  final int id;
  final String ci;
  final String expedido;
  final String paterno;
  final String materno;
  final String nombres;
  final String nacimiento;
  final int celular;
  final String email;
  final String username;
  UserData({
    required this.id,
    required this.ci,
    required this.expedido,
    required this.paterno,
    required this.materno,
    required this.nombres,
    required this.nacimiento,
    required this.celular,
    required this.email,
    required this.username,
  });
  factory UserData.fromJson(Map<String, dynamic> data) {
    return UserData(
      id: data['id'],
      ci: data['ci'],
      expedido: data['expedido'],
      paterno: data['paterno'],
      materno: data['materno'],
      nombres: data['nombres'],
      nacimiento: data['nacimiento'],
      celular: data['celular'],
      email: data['email'],
      username: data['username'],
    );
  }
}

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: FutureBuilder<UserData>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            UserData userData = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  const ProfilePic(),
                  const SizedBox(height: 20),
                  const Text(
                    "Información del Usuario",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  buildInfoItem("CI:", "${userData.ci} ${userData.expedido}"),
                  buildInfoItem("Nombre Completo:",
                      "${userData.nombres} ${userData.paterno} ${userData.materno}"),
                  buildInfoItem("Fecha de Nacimiento:", userData.nacimiento),
                  buildInfoItem("Celular:", userData.celular.toString()),
                  buildInfoItem("Email:", userData.email),
                  buildInfoItem("Username:", userData.username),
                  ProfileMenu(
                    text: "Cerrar sesión",
                    icon: "assets/icons/Log out.svg",
                    press: () {
                      signOut(context); // Llama al método para cerrar sesión
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildInfoItem(String label, String value) {
    return Container(
      margin: EdgeInsets.only(left: 70.0, right: 70.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 14),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  Future<UserData> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userDataString = prefs.getString('userData') ?? '{}';
    Map<String, dynamic> userDataMap = jsonDecode(userDataString);
    return UserData.fromJson(userDataMap);
  }

  void signOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sesion cerrada con exito')),
    );
    Navigator.pushNamedAndRemoveUntil(
      context,
      SignInScreen.routeName,
      (Route<dynamic> route) => false,
    );
  }
}
