/*
{
  "chatroom_id": chatroomid,
  "update_date": DateTime.now(),
  "member" : [
    {
      "A": [
        {
          "chat": "ABCD",
          "update_time": "--", 
        },
      ]
      "B": [
        {
          "chat": "ABCD",
          "update_time": "--", 
        },
      ]
    },
  ]
}
*/

class ChatModel {
  String chatroom_id;
  DateTime update_date;
  List<Map<String,dynamic>> member;

  ChatModel({
    required this.chatroom_id,
    required this.update_date,
    required this.member
  });

  ChatModel.fromJson(Map<String,dynamic> json) : this (
    chatroom_id: json['chatroom_id'],
    update_date: DateTime.parse(json['update_date']),
    member: json['member']
  );

  Map<String,dynamic> toJson (){
    return {
      "chatroom_id": chatroom_id,
      "update_date": update_date.toIso8601String(),
      "member": member
    };
  }
}