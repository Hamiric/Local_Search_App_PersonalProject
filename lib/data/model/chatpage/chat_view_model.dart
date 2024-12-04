import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_search_app_personalproject/data/repo/chat_repo.dart';

class ChatState {
  bool chatNickNameChanged;

  ChatState(this.chatNickNameChanged);
}

class ChatViewModel extends AutoDisposeNotifier<ChatState>{

  @override
  ChatState build(){
    return ChatState(true);
  }

  // 채팅방 첫 채팅 입력
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

  // 닉네임 입력 필드 활성화,비활성화
  void changedChatNickName(){
    state = ChatState(!state.chatNickNameChanged);
  }
}

final chatViewModelProvier = AutoDisposeNotifierProvider<ChatViewModel,ChatState>((){
  return ChatViewModel();
});
