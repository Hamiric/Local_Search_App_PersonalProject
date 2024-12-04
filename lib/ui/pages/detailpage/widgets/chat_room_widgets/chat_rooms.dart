import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_search_app_personalproject/data/model/detailpage/detail_view_model.dart';

class ChatRooms extends StatefulWidget {
  const ChatRooms(
      {super.key, required this.index, this.detailState, this.location});

  final location;
  final detailState;
  final int index;

  @override
  State<ChatRooms> createState() => _ChatRoomsState();
}

class _ChatRoomsState extends State<ChatRooms> {
  final TextEditingController controllerChecker = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? validatorCheckPassWord(String? value) {
    if (value != widget.detailState.chatRooms[widget.index].password) {
      return '비밀번호가 다릅니다!';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 4),
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
          deleteButton(),
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
          child: (widget.detailState.chatRooms[widget.index].imgURL == null ||
                  !Uri.parse(widget.detailState.chatRooms[widget.index].imgURL)
                      .isAbsolute)
              ? Image.asset('assets/images/default_img.jpg')
              : Image.network(
                  widget.detailState.chatRooms[widget.index].imgURL,
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
                  '${widget.detailState.chatRooms[widget.index].chatroom_name}',
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
                '${widget.detailState.chatRooms[widget.index].body.length}명',
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
        '${widget.detailState.chatRooms[widget.index].update_date.year}-${widget.detailState.chatRooms[widget.index].update_date.month}-${widget.detailState.chatRooms[widget.index].update_date.day}';

    String apm =
        widget.detailState.chatRooms[widget.index].update_date.hour > 12
            ? '오후'
            : '오전';
    int hour = widget.detailState.chatRooms[widget.index].update_date.hour > 12
        ? widget.detailState.chatRooms[widget.index].update_date.hour - 12
        : widget.detailState.chatRooms[widget.index].update_date.hour;

    String min = widget.detailState.chatRooms[widget.index].update_date.minute <
            10
        ? '0${widget.detailState.chatRooms[widget.index].update_date.minute}'
        : '${widget.detailState.chatRooms[widget.index].update_date.minute}';
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

  Widget deleteButton() {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return deletePassWordCheckDialog(ref);
                });
          },
          icon: Icon(Icons.delete),
        );
      },
    );
  }

  Widget deletePassWordCheckDialog(WidgetRef ref) {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: Text('채팅방 삭제'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.detailState.chatRooms[widget.index].chatroom_name,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 10,
            ),
            Text('해당 채팅방을 삭제하시려면 비밀번호를 입력해 주세요.'),
            SizedBox(
              height: 10,
            ),
            Form(
                key: formKey,
                child: SizedBox(
                  width: double.maxFinite,
                  child: TextFormField(
                    maxLength: 4,
                    controller: controllerChecker,
                    validator: validatorCheckPassWord,
                    decoration: InputDecoration(
                      hintText: '채팅방 비밀번호를 입력해주세요',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                    ),
                  ),
                )),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('취소')),
          TextButton(
              onPressed: () {
                final bool isValid = formKey.currentState?.validate() ?? false;
                if (!isValid) {
                  return;
                } else {
                  ref.read(detailViewModelProvier.notifier).deleteChatRoom(
                      widget.detailState.chatRooms[widget.index],
                      widget.location.title);

                  Navigator.pop(context);
                }
              },
              child: Text('채팅방 삭제')),
        ],
      );
    });
  }
}
