import 'package:flutter/material.dart';

class ChatRooms extends StatelessWidget {
  const ChatRooms({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 14),
      child: Row(
        // Chat Room Image
        // Room title
        // 가장 최근 글 시간
        children: [
          chatRoomImages(),
          SizedBox(width: 20,),
          chatInfo(),
          SizedBox(width: 10,),
          chatDateTime(),
        ],
      ),
    );
  }

  Widget chatRoomImages() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          width: 50,
          height: 50,
          child: Image.network(
            'https://picsum.photos/300/300',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget chatInfo(){
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '$index 채팅방',
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Text(
                '10명',
                style: TextStyle(
                  color: Colors.grey,
                ),
              )
            ],
          ),
          Text(
            'ㄱㄴㄷㄹㅁㅂㅅ',
            maxLines: 1,
            style: TextStyle(
              color: Colors.grey,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget chatDateTime(){
    return Text(
      '2024-12-01',
      style: TextStyle(
        color: Colors.grey
      ),
    );
  }
}
