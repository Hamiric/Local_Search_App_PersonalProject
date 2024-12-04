import 'dart:convert';

import 'package:http/http.dart';

class ChatRepo {
  // 데이터 입력하기
  Future<bool> insert(
      {required String chatroom_id,
      required DateTime update_date,
      required List<Map<String, dynamic>> member}) async {
    try {
      String url = 'https://local-search-app-35e90-default-rtdb.firebaseio.com/chatrooms.json';

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
}
