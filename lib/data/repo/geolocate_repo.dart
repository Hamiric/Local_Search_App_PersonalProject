import 'package:geolocator/geolocator.dart';

class GeolocateRepo {
  
  // 현재 위치 정보를 획득 가능한지 여부를 판단하는 메서드
  // 1. 기기에서 위치 추적 기능 여부 확인
  // 2. 기기에서 위치 추적 기능 인증이 거부되었을 경우 확인
  Future<void> checkCurrentLocationServiceEnabled() async{
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if(!serviceEnabled){
      return Future.error('현재 위치 정보 서비스 불가');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error('위치정보 퍼미션이 거부되었음');
      }
    }
  }

  // 현재 위치정보 가져오기 전에 위치정보 추적여부 가능 확인
  // 가져오는 값은 위도(latitude) 와 경도(longitude) <둘다 double 값>
  Future<List<double>> currentLocation() async{
    checkCurrentLocationServiceEnabled();
    
    Position position = await Geolocator.getCurrentPosition();

    double latitude = position.latitude;
    double longitude = position.longitude;

    return [latitude,longitude];
  }
}