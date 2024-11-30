import 'package:flutter/material.dart';
import 'package:local_search_app_personalproject/ui/pages/detailpage/detailpage.dart';

class LocalSearchBox extends StatelessWidget {
  const LocalSearchBox({super.key, this.location});

  final location;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => DetailPage(location: location,)),
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
                location.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis
                ),
              ),
              // category
              Text(
                location.category,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis
                ),
              ),
              // roadAddress
              Text(
                location.roadAddress,
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