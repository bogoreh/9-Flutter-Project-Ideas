import 'package:flutter/material.dart';
import '../models/user_model.dart';

class CallItem extends StatelessWidget {
  final User user;

  const CallItem({super.key, required this.user});

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
      subtitle: Row(
        children: [
          const Icon(
            Icons.call_made,
            size: 16,
            color: Colors.green,
          ),
          const SizedBox(width: 4),
          Text(
            user.isOnline ? 'Online' : 'Last seen ${user.lastSeen}',
            style: TextStyle(
              color: user.isOnline ? Colors.green : Colors.grey,
            ),
          ),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.call, color: Color(0xFF00AFF0)),
        onPressed: () {},
      ),
      onTap: () {},
    );
  }
}