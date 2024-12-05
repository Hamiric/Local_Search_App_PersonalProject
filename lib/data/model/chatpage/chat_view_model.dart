import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_search_app_personalproject/data/model/chat_model.dart';
import 'package:local_search_app_personalproject/data/repo/chat_repo.dart';

class ChatState {
  bool chatNickNameChanged;
  List<ChatModel> chats;

  ChatState(this.chatNickNameChanged, this.chats);
}

class ChatViewModel extends AutoDisposeNotifier<ChatState>{

  @override
  ChatState build(){
    return ChatState(true, []);
  }

  // 채팅방 첫 채팅 입력 (put)
  // 자동적으로 앞에 ETag 가 붙는..
  // 일단은 쓰지 않는걸로.. (원하는 로직이 나오질 않네;)
  Future<void> insertNewChat(String chatroom_id, String nickname, String text) async{
    final chatRepo = ChatRepo();
    
    await chatRepo.insert(
      chatroom_id: chatroom_id,
      update_date: DateTime.now(), 
      member: [
        {
          nickname : [
            {
              "chat": text,
              "update_date": DateTime.now().toIso8601String(),
            }
          ]
        },
      ],
    );
  }

  // 채팅방 채팅 업로드 (patch)
  // chatroom_id를 확인하고, (읽고)
  // update_date를 최신으로 수정,
  // member 안의 nickname 확인 후
  // 같은 닉네임이 있으면 chat,update_date 추가
  // 같은 닉네임이 없으면, 새로운 member 추가후 chat,update_date 추가
  Future<void> updateChat(String chatroom_id, String nickname, String text) async{
    final chatRepo = ChatRepo();
    final chats = await chatRepo.readById(chatroom_id);

    final member = chats[0].member;

    // 같은 닉네임이 있는 경우
    bool isCheckNickName = false;
    for(var i in member){
      if(i.containsKey(nickname)){
        i[nickname].add({
          "chat": text,
          "update_date": DateTime.now().toIso8601String(),
        });

        isCheckNickName = true;
        break;
      }
    }

    // 같은 닉네임이 없는 경우
    if(!isCheckNickName){
      member.add({
        nickname : [
          {
            "chat" : text,
            "update_date": DateTime.now().toIso8601String(),
          }
        ]
      });
    }

    await chatRepo.update(
      chatroom_id: chatroom_id, 
      update_date: DateTime.now(), 
      member: member
    );

    await readChat(chatroom_id);
  }

  // 특정 채팅방 읽기
  Future<void> readChat(String chatroom_id) async{
    final chatRepo = ChatRepo();
    final chats = await chatRepo.readById(chatroom_id);

    state = ChatState(state.chatNickNameChanged, chats);
  }


  // 닉네임 입력 필드 활성화,비활성화
  void changedChatNickName(){
    state = ChatState(!state.chatNickNameChanged, state.chats);
  }
}

final chatViewModelProvier = AutoDisposeNotifierProvider<ChatViewModel,ChatState>((){
  return ChatViewModel();
});
