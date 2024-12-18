import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_search_app_personalproject/data/model/chatroom_model.dart';
import 'package:local_search_app_personalproject/data/repo/chat_repo.dart';
import 'package:local_search_app_personalproject/data/repo/chatroom_repo.dart';
import 'package:uuid/uuid.dart';

class DetailState {
  int bottomNavigationBarSelectedIndex;
  List<ChatroomModel> chatRooms;

  String? selectedImagePath;

  String? locationtitle;

  DetailState(this.bottomNavigationBarSelectedIndex, this.chatRooms,
      this.selectedImagePath);
}

class DetailViewModel extends AutoDisposeNotifier<DetailState> {
  @override
  DetailState build() {
    return DetailState(0, [], null);
  }

  // 새로고침
  void refresh() {
    state = DetailState(state.bottomNavigationBarSelectedIndex, state.chatRooms,
        state.selectedImagePath);
  }

  // 바텀 네비게이션 인덱스를 관리하는 메서드
  void changeBottomNavigationBarSelectedIndex(int index) {
    state = DetailState(index, state.chatRooms, state.selectedImagePath);
  }

  // 현재 지역 채팅방 리스트를 가져오는 메서드
  // detailPage가 initState 할때 수행해야 할듯
  // 채팅방을 세팅한다는 의미
  Future<void> setChatRoom(String title) async {
    final chatroomRepo = ChatroomRepo();
    List<ChatroomModel> list = await chatroomRepo.getById(title);

    state.locationtitle = title;

    state = DetailState(
        state.bottomNavigationBarSelectedIndex, list, state.selectedImagePath);
  }

  // 스트림을 통해 실시간 채팅방 리스트 가져오기
  void streamSetChatRoom(String title) {
    final chatroomRepo = ChatroomRepo();

    final stream = chatroomRepo.getByIdStream(title);
    final streamSubscription = stream.listen((chatroom) {
      state = DetailState(state.bottomNavigationBarSelectedIndex, chatroom,
          state.selectedImagePath);
    });
    try {
      ref.onDispose(() {
        print('스트림 종료');
        streamSubscription.cancel();
      });
    } catch (e) {
      print('이미 스트림 종료');
    }
  }

  // 새로운 채팅방을 DB에 넣는 메서드
  // 이미지도 스토리지에 업로드
  // 넣고 다시 DB를 읽기
  Future<void> insertNewChatRoom(String id, String chatroom_name,
      String nickname, String password, String? imgURL) async {
    final chatroomRepo = ChatroomRepo();
    var uuid = Uuid();

    String chatroomuuid = uuid.v4();

    final downloadURL = await chatroomRepo.uploadImage(imgURL, chatroomuuid);

    await chatroomRepo.insert(
        chatroom_id: id + chatroomuuid,
        chatroom_name: chatroom_name,
        update_date: DateTime.now(),
        imgURL: downloadURL,
        password: password,
        creater_info: {
          "nickname": nickname,
        },
        body: [
          {"nickname": nickname}
        ]);

    // 채팅 db 생성
    final chatRepo = ChatRepo();
    await chatRepo.update(
        chatroom_id: id + chatroomuuid,
        update_date: DateTime.now(),
        member: [
          {
            nickname: [
              {
                "chat": "시스템 : 채팅방이 생성되었습니다.",
                "update_date": DateTime.now().toIso8601String(),
              }
            ]
          }
        ]);

    await setChatRoom(id);
  }

  // 채팅방 지우기
  // 채팅 db도 같이 지워짐
  Future<void> deleteChatRoom(ChatroomModel chatRoom, String id) async {
    final chatroomRepo = ChatroomRepo();
    await chatroomRepo.deleteById(chatRoom);

    final chatRepo = ChatRepo();
    await chatRepo.delete(chatRoom.chatroom_id);

    await setChatRoom(id);
  }

  // ImagePicker 이미지 넣기
  void selectedImage(String imagePath) {
    state = DetailState(
        state.bottomNavigationBarSelectedIndex, state.chatRooms, imagePath);
  }

  // 이미지 초기화
  void initSelectedImage() {
    state = DetailState(
        state.bottomNavigationBarSelectedIndex, state.chatRooms, null);
  }
}

final detailViewModelProvier =
    AutoDisposeNotifierProvider<DetailViewModel, DetailState>(() {
  return DetailViewModel();
});
