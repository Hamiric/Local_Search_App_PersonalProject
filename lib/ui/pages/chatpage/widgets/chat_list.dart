import 'package:flutter/material.dart';
import 'package:local_search_app_personalproject/data/model/chat_model.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key, this.chats, this.nickname, this.scrollController});

  final chats;
  final nickname;

  final scrollController;

  @override
  Widget build(BuildContext context) {
    ChatModel chat;
    try {
      chat = chats[0];
    } catch (e) {
      chat =
          ChatModel(chatroom_id: '', update_date: DateTime.now(), member: []);
    }

    List<Map<String, dynamic>> chatList = [];
    // 채팅 재 정렬
    for (var i in chat.member) {
      for (var j in i.values.first) {
        chatList.add({"member": i.keys.first, ...j});
      }
    }

    // 최신이 아래(리스트 뒤쪽)
    chatList.sort((a, b) => a['update_date'].compareTo(b['update_date']));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView.builder(
        controller: scrollController,
        itemCount: chatList.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> chat = chatList[index];

          if (nickname == chat['member']) {
            return rightChat(chat);
          } else {
            return leftChat(chat);
          }
        },
      ),
    );
  }

  Widget leftChat(Map<String, dynamic> chat) {
    return Padding(
      padding: const EdgeInsets.only(right: 60, top: 10, bottom: 10),
      child: Row(
        children: [
          SizedBox(width: 50, child: Text(chat['member'])),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(child: Text(chat['chat'])),
            ),
          ),
        ],
      ),
    );
  }

  Widget rightChat(Map<String, dynamic> chat) {
    return Padding(
      padding: const EdgeInsets.only(left: 60, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.orange[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(child: Text(chat['chat'])),
            ),
          ),
          SizedBox(width: 50, child: Text(chat['member'], textAlign: TextAlign.end,)),
        ],
      ),
    );
  }
}
