import 'package:chatbot_u/constants.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: const Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/chat.jpg"),
          ),
          SizedBox(width: kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Chatbot",
                style: TextStyle(fontSize: 16),
              ),
            ],
          )
        ],
      ),
      actions: const [
        // IconButton(
        //   icon: const Icon(Icons.local_phone),
        //   onPressed: () {},
        // ),
        // IconButton(
        //   icon: const Icon(Icons.videocam),
        //   onPressed: () {},
        // ),
        SizedBox(width: kDefaultPadding / 2),
      ],
    );
  }
}
