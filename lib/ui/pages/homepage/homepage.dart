import 'package:flutter/material.dart';
import 'package:local_search_app_personalproject/ui/pages/homepage/widgets/local_search_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '지역이름검색'
            ),
            onChanged: (text) {
              print(text);
            },
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView.separated(
              itemCount: 4,
              itemBuilder:(context, index) {
                return LocalSearchBox();
              },
              separatorBuilder: (context, index) => SizedBox(height: 20,),
            ),
          ),
        ),
      ),
    );
  }
}