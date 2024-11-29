import 'package:flutter_test/flutter_test.dart';
import 'package:local_search_app_personalproject/data/model/location_model.dart';
import 'package:local_search_app_personalproject/data/repo/location_repo.dart';

void main(){
  test('location_repo_test', () async{
    final locationRepo = LocationRepo();

    List<LocationModel> response = await locationRepo.searchLocation('seoul');

    expect(response.isEmpty, false);
  });
}