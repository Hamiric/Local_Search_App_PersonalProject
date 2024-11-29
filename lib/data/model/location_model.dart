/*
{
  "lastBuildDate": "Fri, 29 Nov 2024 20:05:39 +0900",
  "total": 1,
  "start": 1,
  "display": 1,
  "items": [
    {
      "title": "포시즌스 호텔 서울",
      "link": "http://www.fourseasons.com/kr/seoul",
      "category": "숙박>호텔",
      "description": "",
      "telephone": "",
      "address": "서울특별시 종로구 당주동 29",
      "roadAddress": "서울특별시 종로구 새문안로 97",
      "mapx": "1269752350",
      "mapy": "375706891"
    }
  ]
}
*/

class LocationModel {
  LocationModel({
    required this.title,
    required this.link,
    required this.category,
    required this.description,
    required this.telephone,
    required this.address,
    required this.roadAddress,
    required this.mapx,
    required this.mapy,
  });

  String title;
  String link;
  String category;
  String description;
  String telephone;
  String address;
  String roadAddress;
  String mapx;
  String mapy;

  // Json to Dart
  LocationModel.fromJson(Map<String,dynamic> json) : this(
    title: json['title'],
    link: json['link'],
    category: json['category'],
    description: json['description'],
    telephone: json['telephone'],
    address: json['address'],
    roadAddress: json['roadAddress'],
    mapx: json['mapx'],
    mapy: json['mapy']
  );

  // Dart to Json
  Map<String, dynamic> toJson(){
    return {
      "title": title,
      "link": link,
      "category": category,
      "description": description,
      "telephone": telephone,
      "address": address,
      "roadAddress": roadAddress,
      "mapx": mapx,
      "mapy": mapy
    };
  }
}