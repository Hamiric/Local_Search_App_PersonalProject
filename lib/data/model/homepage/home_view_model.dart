import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_search_app_personalproject/data/model/location_model.dart';
import 'package:local_search_app_personalproject/data/repo/location_repo.dart';

// 홈 상태 클래스
class HomeState {
  List<LocationModel> locations;

  HomeState(this.locations);
}

// 홈 뷰모델 클래스
class HomeViewModel extends Notifier<HomeState>{
  // 상태 초기화
  @override
  HomeState build(){
    return HomeState([]);
  }

  // 검색시 상태 업데이트
  // 검색요청할때 들어오는 값, query
  // List<LocationModel> 을 받아서, response 에 넣고
  // UI 업데이트
  Future<void> searchLocation(String query) async {
    final locationRepo = LocationRepo();
    final response = await locationRepo.searchLocation(query);

    state = HomeState(response);
  }
}

// 뷰 모델 관리자 생성
final homeViewModelProvier = NotifierProvider<HomeViewModel,HomeState>((){
  return HomeViewModel();
});