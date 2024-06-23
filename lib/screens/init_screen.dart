import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:chatbot_u/constants.dart';
import 'package:chatbot_u/screens/favorite/favorite_screen.dart';
import 'package:chatbot_u/screens/home/home_screen.dart';
import 'package:chatbot_u/screens/profile/profile_screen.dart';
import 'package:chatbot_u/screens/chat/message_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chatbot_u/screens/sign_in/sign_in_screen.dart';

const Color inActiveIconColor = Color(0xFFB6B6B6);

class InitScreen extends StatefulWidget {
  const InitScreen({Key? key});

  static String routeName = "/";

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  int currentSelectedIndex = 0;

  void updateCurrentIndex(int index) {
    setState(() {
      currentSelectedIndex = index;
    });
  }

  final pages = [
    const HomeScreen(),
    const FavoriteScreen(),
    // const Center(
    //   child: Text("Chat"),
    // ),
    const MessagesScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else {
          bool userDataExists = snapshot.data ?? false;

          if (userDataExists) {
            return Scaffold(
              body: pages[currentSelectedIndex],
              bottomNavigationBar: BottomNavigationBar(
                onTap: updateCurrentIndex,
                currentIndex: currentSelectedIndex,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      color: inActiveIconColor,
                    ),
                    activeIcon: Icon(
                      Icons.home,
                      color: kPrimaryColor,
                    ),
                    label: "Inicio",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.description,
                      color: inActiveIconColor,
                    ),
                    activeIcon: Icon(
                      Icons.description,
                      color: kPrimaryColor,
                    ),
                    label: "Docs",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.chat_rounded,
                      color: inActiveIconColor,
                    ),
                    activeIcon: Icon(
                      Icons.chat_rounded,
                      color: kPrimaryColor,
                    ),
                    label: "Chat",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                      color: inActiveIconColor,
                    ),
                    activeIcon: Icon(
                      Icons.person,
                      color: kPrimaryColor,
                    ),
                    label: "Perfil",
                  ),
                ],
              ),
            );
          } else {
            // Si userData no existe, redirige a SignInScreen
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, SignInScreen.routeName);
            });

            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        }
      },
    );
  }

  Future<bool> checkUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userDataString = prefs.getString('userData') ?? '';
    return userDataString.isNotEmpty;
  }
}
