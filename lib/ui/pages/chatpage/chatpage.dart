import 'package:flutter/material.dart';
import 'package:local_search_app_personalproject/ui/pages/chatpage/widgets/chat_list.dart';

class Chatpage extends StatelessWidget {
  const Chatpage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('chatPage'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ChatList(),
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    maxLines: 4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}