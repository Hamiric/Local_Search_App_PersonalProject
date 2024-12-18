import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_search_app_personalproject/data/model/detailpage/detail_view_model.dart';
import 'package:local_search_app_personalproject/ui/pages/detailpage/widgets/detail_chat_room.dart';
import 'package:local_search_app_personalproject/ui/pages/detailpage/widgets/detail_inappwebivew.dart';

class DetailPage extends ConsumerStatefulWidget {
  const DetailPage({super.key, this.location});

  final location;

  @override
  ConsumerState<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {

  @override
  void initState() {
    // ref.read(detailViewModelProvier.notifier).setChatRoom(widget.location.title);
    ref.read(detailViewModelProvier.notifier).streamSetChatRoom(widget.location.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final detailState = ref.watch(detailViewModelProvier);

    List<Widget> widgetOptions = [
      DetailInappwebivew(
        location: widget.location,
      ),
      DetailChatRoom(detailState: detailState,location: widget.location,),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${widget.location.title}'),
      ),
      body: SafeArea(
          child: widgetOptions
              .elementAt(detailState.bottomNavigationBarSelectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: detailState.bottomNavigationBarSelectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: (index) {
            ref
                .read(detailViewModelProvier.notifier)
                .changeBottomNavigationBarSelectedIndex(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.web_asset),
              label: 'Link',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat',
            ),
          ]),
    );
  }
}
