import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvvm_getx_sample/src/viewmodels/app_viewmodel.dart';
import 'package:mvvm_getx_sample/src/viewmodels/initial_viewmodel.dart';
import 'package:mvvm_getx_sample/src/views/favorites_view.dart';
import 'package:mvvm_getx_sample/src/views/home_view.dart';

class AppView extends GetView<AppViewModel> {
  const AppView({super.key});

  Widget _bodyWidget() {
    return Obx(() {
      switch (controller.currentNavigationIndex.value) {
        case 0:
          return HomeView();
          break;
        case 1:
          return FavoritesView();
          break;
      }
      return Container();
    });
  }

  Widget _bottomNavigationBarWidget() {
    return Obx(() => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (int index) {
              print('selectedIdx : ' + index.toString());
              controller.changeCurrentIndex(index);
            },
            currentIndex: controller.currentNavigationIndex.value,
            selectedItemColor: Colors.black,
            selectedFontSize: 12,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: '홈'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.star_outline),
                  activeIcon: Icon(Icons.star),
                  label: '관심목록'),
            ]));
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: _bodyWidget(),
      bottomNavigationBar: _bottomNavigationBarWidget(),
    );
  }
}
