import 'package:flutter/material.dart';
import 'package:local_search_app_personalproject/ui/pages/detailpage/widgets/chat_room_widgets/option_bar.dart';

class DetailChatRoom extends StatelessWidget {
  const DetailChatRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10,),
        // 카카오톡 채팅방 리스트 화면 참고할 예정
        OptionBar(),
        // 채팅방 listview
        Expanded(
          child: ListView.builder(
            itemCount: 2,
            itemBuilder:(context, index) {
              return Center(child: Text('$index'));
            },
          ),
        ),
      ],
    );
  }
}