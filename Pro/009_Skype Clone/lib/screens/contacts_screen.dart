import 'package:flutter/material.dart';
import '../data/demo_data.dart';
import '../widgets/contact_item.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search contacts',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: DemoData.demoUsers.length,
            itemBuilder: (context, index) {
              return ContactItem(user: DemoData.demoUsers[index]);
            },
          ),
        ),
      ],
    );
  }
}