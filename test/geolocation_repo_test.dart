import 'package:flutter_test/flutter_test.dart';
import 'package:local_search_app_personalproject/data/repo/geolocate_repo.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('geolocation repo 확인', () {
    GeolocateRepo geolocateRepo = GeolocateRepo();

    print(geolocateRepo.currentLocation());
  });
}
