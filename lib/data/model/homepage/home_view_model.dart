import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_search_app_personalproject/data/model/location_model.dart';
import 'package:local_search_app_personalproject/data/model/vworld_model.dart';
import 'package:local_search_app_personalproject/data/repo/geolocate_repo.dart';
import 'package:local_search_app_personalproject/data/repo/location_repo.dart';
import 'package:local_search_app_personalproject/data/repo/vworld_repo.dart';

// 홈 상태 클래스
class HomeState {
  List<LocationModel> locations;
  String controllerText;
  bool loadState;
  
  HomeState(this.locations, this.loadState, this.controllerText);
}

// 홈 뷰모델 클래스
class HomeViewModel extends Notifier<HomeState>{
  // 상태 초기화
  @override
  HomeState build(){
    return HomeState([], false, '');
  }

  // 검색시 상태 업데이트
  // 검색요청할때 들어오는 값, query
  // List<LocationModel> 을 받아서, response 에 넣고
  // UI 업데이트
  Future<void> searchLocation(String query) async {
    final locationRepo = LocationRepo();
    final response = await locationRepo.searchLocation(query);

    state = HomeState(response, false, query);
  }

  // gps 버튼을 눌렀을때 작동하는 메서드
  // 먼저, geolocator의 권한을 확인하고, 정상적일경우 현재 위치를 확인한다.
  // List<double> 형태의 현재 위치를 받으면, 해당 값을 VWROLD API 에 전달한다.
  // VWROLD API의 지오코더가 위도경도값을 받아 주소를 반환한다.
  // 해당 주소값으로 검색을 실시
  Future<void> searchCurrentLocation() async {
    try{
    final geolocateRepo = GeolocateRepo();
    List<double> currentLatLong = await geolocateRepo.currentLocation();

    final vworldRepo = VworldRepo();
    VworldModel currentAddress = await vworldRepo.searchAddress(currentLatLong);

    await searchLocation(currentAddress.address);
    } catch(e){
      // gps 버튼이 제대로 작동하지 않으므로 대응
      print('gps 미작동');
      state = HomeState(state.locations, false, state.controllerText);
    }
  }

  // 검색을 하게 되는 순간 딜레이 시간에 로딩화면이 뜰 수 있도록 하는 메서드
  void startLoading(){
    state = HomeState(state.locations, true, state.controllerText);
  }
}

// 뷰 모델 관리자 생성
final homeViewModelProvier = NotifierProvider<HomeViewModel,HomeState>((){
  return HomeViewModel();
});