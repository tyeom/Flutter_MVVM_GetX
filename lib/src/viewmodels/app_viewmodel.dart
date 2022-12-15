import 'package:get/get.dart';
import 'package:mvvm_getx_sample/src/services/data_service.dart';

class AppViewModel extends GetxController {
  // 내비게이션바 현재 선택 메뉴 index
  final RxInt currentNavigationIndex = 0.obs;

  void changeCurrentIndex(int index) {
    currentNavigationIndex(index);
  }
}
