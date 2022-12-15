import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:mvvm_getx_sample/src/viewmodels/detail_viewmodel.dart';

class DetailView extends GetView<DetailViewModel> {
  DetailView({super.key});

  final String _articleId = Get.parameters['id'].toString();

  Widget _moreMenuWidget() {
    return PopupMenuButton<int>(
      onSelected: (selectedValue) {
        print(selectedValue);

        switch (selectedValue) {
          case 0:
            // 데이터 삭제
            controller.removeArticle(_articleId);
            // Back 라우트시 result를 true로 전달해서 데이터 갱신 요청
            Get.back(result: true);
            break;
        }
      },
      itemBuilder: (context) =>
          [PopupMenuItem<int>(value: 0, child: Text('삭제'))],
      icon: Icon(
        Icons.more_vert,
      ),
    );
  }

  Widget _bodyWidget() {
    // 상세 데이터 요청
    controller.fetchDetailArticle(_articleId);

    return Container(child: Obx(
      () {
        // 상세 데이터 요청중
        if (controller.isDataFetching.value) {
          return const Center(
              child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 252, 113, 49)));
        }
        // 상세 데이터 로드 오류
        else if (controller.article == null) {
          return Center(child: Text("데이터 요청중 오류가 발생되었습니다."));
        }
        // 데이터 표시
        else {
          return Column(
            children: [
              Text(
                controller.article!.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Container(
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                color: Colors.grey.withOpacity(0.3),
              ),
              Text(
                controller.article!.content,
                style: TextStyle(fontSize: 20),
              ),
            ],
          );
        }
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Get.back(result: false)),
            actions: [
              _moreMenuWidget(),
            ]),
        body: _bodyWidget());
  }
}
