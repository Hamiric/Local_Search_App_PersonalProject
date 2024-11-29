import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:local_search_app_personalproject/data/model/location_model.dart';

void main(){

  String testJson = """
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
""";

  test('test name', () {
    var testlocation = LocationModel.fromJson(jsonDecode(testJson));
    
    expect(testlocation.mapx, "1269752350");
    print(testlocation.toJson());
  });
}