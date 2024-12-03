import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_search_app_personalproject/data/model/chatroom_model.dart';
import 'package:local_search_app_personalproject/data/repo/chatroom_repo.dart';
import 'package:uuid/uuid.dart';

class DetailState{
  int bottomNavigationBarSelectedIndex;
  List<ChatroomModel> chatRooms;

  DetailState(this.bottomNavigationBarSelectedIndex, this.chatRooms);
}

class DetailViewModel extends AutoDisposeNotifier<DetailState>{

  @override
  DetailState build(){
    return DetailState(0, []);
  }

  // 바텀 네비게이션 인덱스를 관리하는 메서드
  void changeBottomNavigationBarSelectedIndex(int index){
    state = DetailState(index, state.chatRooms);
  }

  // 현재 지역 채팅방 리스트를 가져오는 메서드
  // detailPage가 initState 할때 수행해야 할듯
  // 채팅방을 세팅한다는 의미
  Future<void> setChatRoom(String title) async{
    final chatroomRepo = ChatroomRepo();
    List<ChatroomModel> list = await chatroomRepo.getById(title);

    state = DetailState(state.bottomNavigationBarSelectedIndex, list);
  }

  // 새로운 채팅방을 DB에 넣는 메서드
  // 넣고 다시 DB를 읽기
  Future<void> insertNewChatRoom(String id, String chatroom_name, String nickname, String password, String imgURL) async{
    final chatroomRepo = ChatroomRepo();
    var uuid = Uuid();

    await chatroomRepo.insert(
      chatroom_id: id + uuid.v4(),
      chatroom_name : chatroom_name,
      update_date: DateTime.now(),
      imgURL: imgURL,
      password: '1111',
      creater_info: {
        "nickname": nickname,
        "imgURL": imgURL
      },
      body: [
        {"nickname": nickname, "imgURL": imgURL}
      ]);
    
    await setChatRoom(id);
  }
}

final detailViewModelProvier = AutoDisposeNotifierProvider<DetailViewModel,DetailState>((){
  return DetailViewModel();
});

