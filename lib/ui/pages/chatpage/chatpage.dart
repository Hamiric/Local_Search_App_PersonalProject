import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_search_app_personalproject/data/model/chatpage/chat_view_model.dart';
import 'package:local_search_app_personalproject/ui/pages/chatpage/widgets/chat_list.dart';

class Chatpage extends ConsumerStatefulWidget {
  const Chatpage(this.chatroom, {super.key});

  final chatroom;

  @override
  ConsumerState<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends ConsumerState<Chatpage> {
  final TextEditingController controllerChat = TextEditingController();
  final TextEditingController controllerNickName = TextEditingController();
  final ScrollController controllerScroll = ScrollController();

  @override
  void didChangeDependencies() async {
    await ref
        .read(chatViewModelProvier.notifier)
        .readChat(widget.chatroom.chatroom_id);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controllerChat.dispose();
    controllerNickName.dispose();
    controllerScroll.dispose();
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
          actions: [
            submitButton(chatState)
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ChatList(
                  chats: chatState.chats,
                  nickname: controllerNickName.text,
                  scrollController: controllerScroll,
                ),
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
                                        hintStyle:
                                            TextStyle(color: Colors.grey)),
                                  ))
                              : Text(controllerNickName.text),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(chatViewModelProvier.notifier)
                                  .changedChatNickName();
                              if (controllerNickName.text.isEmpty) {
                                controllerNickName.text = 'ㅇㅇ';
                              }
                            },
                            child: chatState.chatNickNameChanged
                                ? Text('닉네임 확정하기')
                                : Text('닉네임 수정하기'),
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
      ),
    );
  }

  Widget submitButton(var chatState) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.amber[200]),
        ),
        onPressed: () {
          if (chatState.chatNickNameChanged) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('닉네임을 설정해 주세요'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Center(child: Text('확인')),
                      )
                    ],
                  );
                });
          } else if (!chatState.chatNickNameChanged &&
              controllerChat.text.isEmpty) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('채팅을 입력해 주세요'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Center(child: Text('확인')),
                      )
                    ],
                  );
                });
          } else {
            ref
                .read(chatViewModelProvier.notifier)
                .updateChat(widget.chatroom.chatroom_id, controllerNickName.text,
                    controllerChat.text)
                .then((e) {
              // 채팅이 정상처리됬다면, 스크롤 맨 아래로
              controllerScroll.jumpTo(controllerScroll.position.maxScrollExtent);
            });
            controllerChat.text = '';
          }
        },
        child: Icon(
          Icons.send,
        ),
      ),
    );
  }
}
