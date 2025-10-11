import 'package:flutter/material.dart';
import '../data/demo_data.dart';
import '../widgets/chat_item.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: DemoData.demoUsers.length,
      itemBuilder: (context, index) {
        return ChatItem(user: DemoData.demoUsers[index]);
      },
    );
  }
}