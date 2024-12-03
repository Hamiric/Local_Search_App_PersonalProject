import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView.separated(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            child: Text('$index'),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 10,);
        },
      ),
    );
  }
}