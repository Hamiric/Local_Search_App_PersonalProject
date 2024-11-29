import 'package:flutter/material.dart';
import 'package:local_search_app_personalproject/ui/pages/detailpage/detailpage.dart';

class LocalSearchBox extends StatelessWidget {
  const LocalSearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => DetailPage()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.grey[400]!),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title
              Text(
                '삼성1동 주민센터',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis
                ),
              ),
              // category
              Text(
                '공공, 사회기관>행정복지센터',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis
                ),
              ),
              // roadAddress
              Text(
                '서울특별시 강남구 봉은차로 616 삼성1동 주민센터',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}