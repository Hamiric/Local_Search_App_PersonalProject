import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_search_app_personalproject/data/model/homepage/home_view_model.dart';
import 'package:local_search_app_personalproject/ui/pages/homepage/widgets/local_search_box.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeViewModelProvier);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _searchController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: '지역이름검색'),
            // 에뮬환경에서는 onsubmitted보다 onChanged가 더 좋아보임 ㅎㅎ
            onChanged: (text) {
              ref.read(homeViewModelProvier.notifier).searchLocation(text);
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                ref.read(homeViewModelProvier.notifier).searchCurrentLocation();
              }, 
              icon: Icon(Icons.gps_fixed),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView.separated(
              itemCount: homeState.locations.length,
              itemBuilder: (context, index) {
                return LocalSearchBox(location: homeState.locations[index],);
              },
              separatorBuilder: (context, index) => SizedBox(
                height: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
