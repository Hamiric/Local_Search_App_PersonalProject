import 'dart:convert';

import 'package:http/http.dart';
import 'package:local_search_app_personalproject/data/model/location_model.dart';

class LocationRepo {
  
  // 지역 검색 - http 통신으로 api의 json값 가져오기
  // 가져오는 기준은, 입력된 query 값
  Future<List<LocationModel>> searchLocation(String query) async {
    final client = Client();

    final response = await client.get(
      Uri.parse('https://openapi.naver.com/v1/search/local.json?query=$query'),
      headers: {
        'X-Naver-Client-Id': 'jfHyBNLifIBppk63vqd0',
        'X-Naver-Client-Secret': 'Xv_qhMk9VF',
      }
    );

    if(response.statusCode == 200){
      Map<String,dynamic> map = jsonDecode(response.body);

      // List.from을 통해 원본데이터를 보호하고,
      // 실제 가져오는 값을 List형태로 고정
      final items = List.from(map['items']);

      // [{},{}] 형태의 items 리스트를
      // [<LocationModel>,<LocationModel>] 형태로 변환 
      // (.toList()를 통해 {<>,<>} 형태 [<>,<>]로 변환됨)
      final list = items.map((e){
        return LocationModel.fromJson(e);
      }).toList();

      return list;
    } else {
      return [];
    }
  }
}