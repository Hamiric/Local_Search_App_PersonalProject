import 'package:flutter/material.dart';

class ChatRooms extends StatelessWidget {
  const ChatRooms({super.key, required this.index, this.detailState});

  final detailState;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 24),
      child: Row(
        // Chat Room Image
        // Room title
        // 가장 최근 글 시간
        children: [
          chatRoomImages(),
          SizedBox(
            width: 10,
          ),
          chatInfo(),
          SizedBox(
            width: 10,
          ),
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
          child: (detailState.chatRooms[index].imgURL == null ||
                  !Uri.parse(detailState.chatRooms[index].imgURL).isAbsolute)
              ? Image.asset('assets/images/default_img.jpg')
              : Image.network(
                  detailState.chatRooms[index].imgURL,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }

  Widget chatInfo() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${detailState.chatRooms[index].chatroom_name}',
                  maxLines: 1,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '${detailState.chatRooms[index].body.length}명',
                style: TextStyle(
                  color: Colors.grey,
                ),
              )
            ],
          ),
          Text(
            'ㄱㄴㄷㄹㅁㅂㅅㅇㅈㅊㅋㅍㅌㅎ',
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

  Widget chatDateTime() {
    String date =
        '${detailState.chatRooms[index].update_date.year}-${detailState.chatRooms[index].update_date.month}-${detailState.chatRooms[index].update_date.day}';

    String apm =
        detailState.chatRooms[index].update_date.hour > 12 ? '오후' : '오전';
    int hour = detailState.chatRooms[index].update_date.hour > 12
        ? detailState.chatRooms[index].update_date.hour - 12
        : detailState.chatRooms[index].update_date.hour;

    String min = detailState.chatRooms[index].update_date.minute < 10
        ? '0${detailState.chatRooms[index].update_date.minute}'
        : '${detailState.chatRooms[index].update_date.minute}';
    String time = '$apm $hour:$min';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          date,
          style: TextStyle(color: Colors.grey),
        ),
        Text(
          time,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
