import 'dart:convert';

import 'package:http/http.dart';
import 'package:local_search_app_personalproject/data/model/vworld_model.dart';

class VworldRepo {
  String key = '320B7684-135E-315F-A632-A9CBC768DCA3';

  // 주소 검색 - http 통신으로 api의 json값 가져오기
  // 가져오는 기준은, 입력된 query 값
  Future<VworldModel> searchAddress(List<double> currentLatLong) async {
    final client = Client();

    String longlat = '${currentLatLong[1]},${currentLatLong[0]}';

    print(longlat);

    final response = await client.get(
      Uri.parse(
          'https://api.vworld.kr/req/address?service=address&request=getAddress&point=$longlat&type=parcel&key=$key'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      return VworldModel.fromJson(map);
    } else {
      return VworldModel(address: '');
    }
  }
}
