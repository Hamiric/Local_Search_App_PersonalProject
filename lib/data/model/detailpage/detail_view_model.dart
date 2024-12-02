import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailState{
  int bottomNavigationBarSelectedIndex;

  DetailState(this.bottomNavigationBarSelectedIndex);
}

class DetailViewModel extends AutoDisposeNotifier<DetailState>{

  @override
  DetailState build(){
    return DetailState(0);
  }

  // 바텀 네비게이션 인덱스를 관리하는 메소드
  void changeBottomNavigationBarSelectedIndex(int index){
    
    state = DetailState(index);
  }
}

final detailViewModelProvier = AutoDisposeNotifierProvider<DetailViewModel,DetailState>((){
  return DetailViewModel();
});

