import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_search_app_personalproject/data/repo/chatroom_repo.dart';
import 'package:local_search_app_personalproject/ui/pages/homepage/homepage.dart';
import 'package:uuid/uuid.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final chatroomRepo = ChatroomRepo();
  
  /*
  var uuid = Uuid();
  String id = '김천동 주민센터' + uuid.v4();
  await chatroomRepo.insert(
      chatroom_id: id,
      chatroom_name : 'ABCD',
      update_date: DateTime.now(),
      imgURL: "https://picsum.photos/300/300",
      password: '1111',
      creater_info: {
        "nickname": "tester",
        "imgURL": "https://picsum.photos/300/300"
      },
      body: [
        {"nickname": "tester", "imgURL": "https://picsum.photos/300/300"}
      ]);
  */
  /*
  print((await chatroomRepo.getAll()).length);
  print((await chatroomRepo.getSearch('여의동 주민센터')).length);
  */

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
