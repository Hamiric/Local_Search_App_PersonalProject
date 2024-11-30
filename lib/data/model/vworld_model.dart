/*
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
*/

// result의 structure의 level4L 이 '--동' 형태로 가장 검색하기 쉬워보여서 이걸로함 
class VworldModel {
  VworldModel({
    required this.address,
  });

  String address;

  // Json to Dart
  VworldModel.fromJson(Map<String,dynamic> json) : this(
    address: json['response']['result'][0]['structure']['level4L'],
  );

  Map<String,dynamic> toJson(){
    return {
      "address": address,
    };
  }
}