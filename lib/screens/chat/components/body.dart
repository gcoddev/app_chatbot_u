// Body.dart
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:chatbot_u/constants.dart';
import 'package:chatbot_u/models/ChatMessage.dart';
import 'chat_input_field.dart';
import 'message.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<ChatMessage> chatMessages = [];
  // late Timer timer;

  @override
  void initState() {
    super.initState();
    fetchChatMessages();

    // timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    //   fetchChatMessages();
    // });
  }

  // @override
  // void dispose() {
  // timer.cancel();
  //   super.dispose();
  // }

  Future<void> fetchChatMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userDataString = prefs.getString('userData') ?? '{}';
    Map<String, dynamic> userData = jsonDecode(userDataString);
    int userId = userData['id'];

    final url = 'http://192.168.0.10:3001/api/chat/$userId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<ChatMessage> messages =
          data.map((item) => ChatMessage.fromJson(item)).toList();

      setState(() {
        chatMessages = messages;
      });
    } else {
      throw Exception('Failed to load chat messages');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) =>
                  Message(message: chatMessages[index]),
            ),
          ),
        ),
        const ChatInputField(),
      ],
    );
  }
}
