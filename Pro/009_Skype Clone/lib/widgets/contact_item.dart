import 'package:flutter/material.dart';
import '../models/user_model.dart';

class ContactItem extends StatelessWidget {
  final User user;

  const ContactItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 28,
        backgroundImage: NetworkImage(user.imageUrl),
      ),
      title: Text(
        user.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        user.isOnline ? 'Online' : 'Last seen ${user.lastSeen}',
        style: TextStyle(
          color: user.isOnline ? Colors.green : Colors.grey,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.message, color: Color(0xFF00AFF0)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.call, color: Color(0xFF00AFF0)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}