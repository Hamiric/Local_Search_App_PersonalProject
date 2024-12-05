import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart';
import 'package:local_search_app_personalproject/data/model/chat_model.dart';

class ChatRepo {
  // 데이터 입력하기
  Future<bool> insert(
      {required String chatroom_id,
      required DateTime update_date,
      required List<Map<String, dynamic>> member}) async {
    try {
      String url =
          'https://local-search-app-35e90-default-rtdb.firebaseio.com/$chatroom_id.json';

      final client = Client();
      final response = await client.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "chatroom_id": chatroom_id,
            "update_date": update_date.toIso8601String(),
            "member": member
          }));

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // 데이터 업로드
  Future<bool> update(
      {required String chatroom_id,
      required DateTime update_date,
      required List<Map<String, dynamic>> member}) async {
    try {
      String url =
          'https://local-search-app-35e90-default-rtdb.firebaseio.com/$chatroom_id.json';

      final client = Client();
      final response = await client.patch(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "update_date": update_date.toIso8601String(),
            "member": member
          }));

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // 특정 chatroom 안의 데이터 읽기
  Future<List<ChatModel>> readById(String chatroom_id) async {
    try {
      String url =
          'https://local-search-app-35e90-default-rtdb.firebaseio.com/$chatroom_id.json';

      final client = Client();
      final response = await client.get(Uri.parse(url));

      final json = jsonDecode(response.body);

      Map<String, dynamic> item = {"chatroom_id": chatroom_id, ...json};

      final data = ChatModel.fromJson(item);

      return [data];
    } catch (e) {
      print('채팅 데이터 없음');
    }
    return [];
  }

  // 데이터 실시간 읽기
  Stream<List<ChatModel>> readByIdStream(String chatroom_id) {
    final FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference ref = database.ref().child(chatroom_id);

    return ref.onValue.map((event) {
      Map<Object?, Object?> rawData =
          event.snapshot.value as Map<Object?, Object?>;

      Map<String, dynamic> data = rawData.map((key, value) {
        return MapEntry(key.toString(), value);
      });

      print(data);

      Map<String, dynamic> item = {
        "chatroom_id": chatroom_id,
        ...data,
      };

      print(item);

      // 아니 분명 Map<String,dynamic> 으로 형변환이 되어야 하는데;
      // 위에 Future거는 잘되는데 왜 이건 안되는거야; (ㅠㅠ)
      /// [ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception: type '_Map<Object?, Object?>' is not a subtype of type 'Map<String, dynamic>' in type cast

      final value = ChatModel.fromJson(item);

      print('whywhy >>> $item');
      print('범인이 여기였어?');

      return [value];
    });
  }

  // 특정 채팅방 지우면서, 채팅 db도 지우기
  Future<void> delete(String chatroom_id) async {
    try {
      String url =
          'https://local-search-app-35e90-default-rtdb.firebaseio.com/$chatroom_id.json';

      final client = Client();
      final response = await client.delete(Uri.parse(url));
    } catch (e) {
      print('채팅 지우기 오류');
    }
  }
}
