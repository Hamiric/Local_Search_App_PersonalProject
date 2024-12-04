import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:local_search_app_personalproject/data/model/chatroom_model.dart';

class ChatroomRepo {
  // 'chatroom' 콜렉션의 문서들 전부 가져오기
  Future<List<ChatroomModel>> getAll() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collectionRef = firestore.collection('chatroom');

    QuerySnapshot snapshot = await collectionRef.get();
    List<QueryDocumentSnapshot> documentSnapshots = snapshot.docs;

    final list = documentSnapshots.map((e) {
      final map = e.data() as Map<String, dynamic>;
      final newMap = {
        'chatroom_id': e.id,
        ...map,
      };

      return ChatroomModel.fromJson(newMap);
    }).toList();

    return list;
  }

  // 'chatroom' 콜렉션의 문서들중 query 가 앞에 있는 채팅방만 반환
  // 채팅방 읽어올때, update_date를 기준으로 정렬되어 반환
  // 가장 최근 업데이트된 채팅방부터 최상위
  Future<List<ChatroomModel>> getById(String query) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collectionRef = firestore.collection('chatroom');

    QuerySnapshot snapshot = await collectionRef.get();
    List<QueryDocumentSnapshot> documentSnapshots = snapshot.docs;

    final docs = documentSnapshots.where((e){
      return e.id.contains(query);
    });

    final list = docs.map((e) {
      final map = e.data() as Map<String, dynamic>;
      final newMap = {
        'chatroom_id': e.id,
        ...map,
      };

      return ChatroomModel.fromJson(newMap);
    }).toList();

    list.sort((a,b) => a.update_date.compareTo(b.update_date));
    final orderList = list.reversed.toList();

    return orderList;
  }

  // 'chatroom' 에 문서로 데이터 집어넣기
  // 즉, 새로운 채팅방 만드는 메서드
  Future<bool> insert(
      {required String chatroom_id,
      required String chatroom_name,
      required DateTime update_date,
      required String imgURL,
      required String password,
      required Map<String, dynamic> creater_info,
      required List<Map<String, dynamic>> body}) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference collectionRef = firestore.collection('chatroom');

      final docRef = collectionRef.doc(chatroom_id);

      final map = {
        "chatroom_name": chatroom_name,
        "update_date": update_date.toIso8601String(),
        "imgURL": imgURL,
        "password": password,
        "creater_info": creater_info,
        "body": body
      };

      await docRef.set(map);
      return true;
    } catch (e) {
      return false;
    }
  }

  // 이미지 업로드 (파이어베이스 스토리지)
  // 업로드 이후 DownloadURL 반환
  Future<String> uploadImage(String path, String id) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageRef = storage.ref();
    final imageRef = storageRef.child('${DateTime.now().microsecondsSinceEpoch}_$id');

    await imageRef.putFile(File(path));
    final url = await imageRef.getDownloadURL();
    return url;
  }
}
