import 'package:flutter_test/flutter_test.dart';


// 아하, 시간대가 왜 이상한가 했더니
// 에뮬레이터 시간대(기기 기준) 으로 값이 들어가는 거였군..

// 테스트코드는 컴퓨터에서 돌아가니 제대로 나오는거고..
void main() {
  test('Local time zone information test', () {
    DateTime now = DateTime.now();
    DateTime utcNow = now.toUtc();
    String timeZoneName = now.timeZoneName;
    Duration timeZoneOffset = now.timeZoneOffset;

    // 로컬 시간 출력
    print('로컬 시간: $now');
    // UTC 시간 출력
    print('UTC 시간: $utcNow');
    // 시간대 이름 출력
    print('시간대 이름: $timeZoneName');
    // 시간대 오프셋 출력
    print('UTC 오프셋: $timeZoneOffset');

    // 허용 가능한 시간대 이름 리스트
    const allowedTimeZones = ['KST', 'Asia/Seoul', '대한민국 표준시'];

    // 시간대 이름 검증
    expect(allowedTimeZones.contains(timeZoneName), isTrue,
        reason: 'Unexpected timeZoneName: $timeZoneName');
    // UTC 오프셋 검증
    expect(timeZoneOffset.inHours, 9); // UTC+9 시간대인지 확인
  });
}

