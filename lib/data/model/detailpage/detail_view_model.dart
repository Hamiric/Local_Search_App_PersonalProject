import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_search_app_personalproject/data/model/chatroom_model.dart';
import 'package:local_search_app_personalproject/data/repo/chatroom_repo.dart';

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

  // 바텀 네비게이션 인덱스를 관리하는 메소드
  void changeBottomNavigationBarSelectedIndex(int index){
    state = DetailState(index, state.chatRooms);
  }

  // 현재 지역 채팅방 리스트를 가져오는 메소드
  // detailPage가 initState 할때 수행해야 할듯
  // 채팅방을 세팅한다는 의미
  Future<void> setChatRoom(String title) async{
    final chatroomRepo = ChatroomRepo();
    List<ChatroomModel> list = await chatroomRepo.getSearch(title);

    state = DetailState(state.bottomNavigationBarSelectedIndex, list);
  }
}

final detailViewModelProvier = AutoDisposeNotifierProvider<DetailViewModel,DetailState>((){
  return DetailViewModel();
});

