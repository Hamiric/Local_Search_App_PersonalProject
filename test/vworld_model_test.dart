import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:local_search_app_personalproject/data/model/vworld_model.dart';

void main(){

  String testJson = """
{
  "response": {
    "service": {
      "name": "address",
      "version": "2.0",
      "operation": "getAddress",
      "time": "10(ms)"
    },
    "status": "OK",
    "input": {
      "point": {
        "x": "126.678235264",
        "y": "37.526642192 "
      },
      "crs": "",
      "type": "parcel"
    },
    "result": [
      {
        "zipcode": "",
        "type": "parcel",
        "text": "인천광역시 서구 가정동 산 22-36",
        "structure": {
          "level0": "대한민국",
          "level1": "인천광역시",
          "level2": "서구",
          "level3": "",
          "level4L": "가정동",
          "level4LC": "2826010800",
          "level4A": "",
          "level4AC": "",
          "level5": "산22-36임",
          "detail": ""
        }
      }
    ]
  }
}
""";

  test('test name', () {
    var testlocation = VworldModel.fromJson(jsonDecode(testJson));
    
    expect(testlocation.address, "가정동");
    print(testlocation.toJson());
  });
}