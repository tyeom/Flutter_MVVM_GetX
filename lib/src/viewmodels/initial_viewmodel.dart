import 'package:get/get.dart';
import 'package:mvvm_getx_sample/src/services/data_service.dart';
import 'package:mvvm_getx_sample/src/viewmodels/app_viewmodel.dart';
import 'package:mvvm_getx_sample/src/viewmodels/home_viewmodel.dart';

class InitialViewModel implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataService>(() => DataService());
    Get.lazyPut<AppViewModel>(() => AppViewModel());
    Get.lazyPut<HomeViewModel>(() => HomeViewModel());
  }
}
