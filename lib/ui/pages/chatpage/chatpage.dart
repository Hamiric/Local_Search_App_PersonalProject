import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_search_app_personalproject/data/model/chatpage/chat_view_model.dart';
import 'package:local_search_app_personalproject/ui/pages/chatpage/widgets/chat_list.dart';
import 'package:local_search_app_personalproject/ui/pages/chatpage/widgets/custom_floating_action_button_location.dart';

class Chatpage extends ConsumerStatefulWidget {
  const Chatpage(this.chatroom, {super.key});

  final chatroom;

  @override
  ConsumerState<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends ConsumerState<Chatpage> {
  final TextEditingController controllerChat = TextEditingController();
  final TextEditingController controllerNickName = TextEditingController();

  @override
  void dispose() {
    controllerChat.dispose();
    controllerNickName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatViewModelProvier);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.chatroom.chatroom_name),
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
                  child: Row(
                    children: [
                      Column(
                        children: [
                          chatState.chatNickNameChanged
                              ? SizedBox(
                                width: 100,
                                child: TextField(
                                  controller: controllerNickName,
                                  decoration: InputDecoration(
                                    hintText: '닉네임',
                                    hintStyle: TextStyle(
                                      color: Colors.grey
                                    )
                                  ),
                                )
                              )
                              : Text(controllerNickName.text),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              ref.read(chatViewModelProvier.notifier).changedChatNickName();
                              if(controllerNickName.text.isEmpty){
                                controllerNickName.text = 'ㅇㅇ';
                              }
                            },
                            child: chatState.chatNickNameChanged ? Text('닉네임 확정하기') : Text('닉네임 수정하기'),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextField(
                          controller: controllerChat,
                          maxLines: 4,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // 아 버튼위치 맛없네; 생각나면 집어넣으면서 하다보니 그만;;
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            ref.read(chatViewModelProvier.notifier).insertNewChat(widget.chatroom.chatroom_id, controllerNickName.text, controllerChat.text);
            controllerChat.text = '';
          },
          child: Icon(
            Icons.send,
          ),
        ),
        floatingActionButtonLocation: CustomFloatingActionButtonLocation(offsetY: 160),
      ),
    );
  }
}
