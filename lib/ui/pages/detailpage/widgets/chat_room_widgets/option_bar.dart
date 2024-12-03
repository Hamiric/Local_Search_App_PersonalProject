import 'package:flutter/material.dart';

class OptionBar extends StatelessWidget {
  const OptionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          chatOption(),
          Spacer(),
          addChat(),
        ],
      ),
    );
  }

  Widget addChat() {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.add_box_outlined,
        color: Colors.grey,
        size: 32,
      )
    );
  }

  Widget chatOption() {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Text(
            '채팅',
            style: TextStyle(
              fontSize: 24, 
              fontWeight: FontWeight.bold,
              height: 2
            ),
          ),
          Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }
}
