import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import 'package:chatbot_u/models/ChatMessage.dart';
import 'message.dart';
import 'package:chatbot_u/env.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with WidgetsBindingObserver {
  List<ChatMessage> chatMessages = [];
  late TextEditingController messageController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
    fetchChatMessages();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    messageController.dispose();
    _scrollController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (WidgetsBinding.instance.window.viewInsets.bottom > 0) {
      _scrollToBottom();
    }
  }

  Future<void> fetchChatMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userDataString = prefs.getString('userData') ?? '{}';
    Map<String, dynamic> userData = jsonDecode(userDataString);
    int userId = userData['id'];

    final url = apiUrl + '/api/chat/$userId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<ChatMessage> messages =
          data.map((item) => ChatMessage.fromJson(item)).toList();

      setState(() {
        chatMessages = messages;
      });

      // Desplazarse al último mensaje
      _scrollToBottom();
    } else {
      throw Exception('Failed to load chat messages');
    }
  }

  Future<void> sendMessage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userDataString = prefs.getString('userData') ?? '{}';
    Map<String, dynamic> userData = jsonDecode(userDataString);
    int userId = userData['id'];

    String message = messageController.text.trim();
    messageController.clear();
    fetchChatMessages();
    final url = apiUrl + '/api/ask';
    final response = await http.post(
      Uri.parse(url),
      body: {
        "user_id": userId.toString(),
        "user_question": message,
      },
    );

    if (response.statusCode == 200) {
      fetchChatMessages();
    } else {
      throw Exception('Failed to send message');
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: chatMessages.length,
              itemBuilder: (context, index) =>
                  Message(message: chatMessages[index]),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
            vertical: kDefaultPadding / 2,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 32,
                color: const Color(0xFF087949).withOpacity(0.08),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: messageController,
                            decoration: const InputDecoration(
                              hintText: "Escriba su mensaje",
                              isDense: true,
                              border: InputBorder.none,
                            ),
                            onTap: () {
                              _scrollToBottom();
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            sendMessage();
                          },
                          icon: Icon(
                            Icons.send,
                            color: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .color!
                                .withOpacity(0.64),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
