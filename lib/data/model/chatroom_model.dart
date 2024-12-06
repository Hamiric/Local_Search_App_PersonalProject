/*
{
  "chatroom_id": "(location.title)_uuid.v4()",
  "update_date": DateTime.now(),
  "imgURL": "https://picsum.photos/300/300",
  "password": "1111",
  "creater_info": {
    "nickname" : "tester",
    "imgURL" : "https://picsum.photos/300/300" -- 없어짐
  },
  "body" : [
    {
      "nickname" : "tester",
      "imgURL" : "https://picsum.photos/300/300" -- 없어짐
    }
  ]
}
*/

class ChatroomModel {
  String chatroom_id;
  String chatroom_name;
  DateTime update_date;
  String imgURL;
  String password;
  Map<String,dynamic> creater_info;
  List<Map<String,dynamic>> body;

  ChatroomModel({
    required this.chatroom_id,
    required this.chatroom_name,
    required this.update_date,
    required this.imgURL,
    required this.password,
    required this.creater_info,
    required this.body
  });

  ChatroomModel.fromJson(Map<String,dynamic> json) : this (
    chatroom_id : json['chatroom_id'],
    chatroom_name: json['chatroom_name'],
    update_date : DateTime.parse(json['update_date']),
    imgURL : json['imgURL'],
    password : json['password'],
    creater_info : json['creater_info'],
    body : (json['body'] as List).map((item) => item as Map<String, dynamic>).toList(),
  );

  Map<String,dynamic> toJson(){
    return {
      "chatroom_id" : chatroom_id,
      "chatroom_name" : chatroom_name,
      "update_date" : update_date.toIso8601String(),
      "imgURL" : imgURL,
      "password" : password,
      "creater_info" : creater_info,
      "body" : body
    };
  }
}