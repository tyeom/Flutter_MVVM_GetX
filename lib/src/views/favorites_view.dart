import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvvm_getx_sample/src/models/article_model.dart';
import 'package:mvvm_getx_sample/src/viewmodels/home_viewmodel.dart';

class FavoritesView extends GetView<HomeViewModel> {
  const FavoritesView({super.key});

  // Article 데이터 표시
  Widget _makeArticleWidget(ArticleModel article) {
    return GestureDetector(
      onTap: () async {
        print(article.id);
        final result = await Get.toNamed('/detail/${article.id}');
        if (result) {
          print('데이터 갱신');
          controller.fetchArticles();
        }
      },
      child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(children: [
            ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: CachedNetworkImage(
                  placeholder: (_, __) => new CircularProgressIndicator(),
                  errorWidget: (_, __, ___) => Icon(Icons.error),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  imageUrl:
                      'http://arong.info:7004/articlesImage/${article.photoList![0]}',
                )),
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(left: 20, top: 2),
                  height: 100,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              article.title,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.clip,
                            ),
                            GestureDetector(
                              onTap: () {
                                // 즐겨찾기 업데이트
                                controller.updateFavorites(
                                    article.id!, !article.favorites);
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Icon(article.favorites
                                    ? Icons.star
                                    : Icons.star_outline),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Text(
                          article.town,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.3)),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Text(
                          article.price <= 0
                              ? "무료나눔"
                              : article.price.toString(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ])),
            )
          ])),
    );
  }

  Widget _bodyWidget() {
    return Container(child:
        // ViewModel(컨트롤러) 통해 데이터 표시
        Obx(
      () {
        // 전체 아티클 데이터 리스트
        List<ArticleModel>? articleList = controller.articleList;

        // 원본 데이터 없음
        if (articleList == null || articleList.length <= 0) {
          return Center(child: Text("원본 데이터가 없습니다."));
        } else {
          // 즐겨찾기 필터
          List<ArticleModel> favoritesList =
              articleList.where((item) => item.favorites).toList();

          if (favoritesList.length <= 0) {
            return Center(child: Text("즐겨찾기 데이터가 없습니다."));
          }

          return Container(
            child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 10),
                physics: ClampingScrollPhysics(), // bounce 효과 제거
                itemBuilder: (BuildContext _context, int index) {
                  return _makeArticleWidget(favoritesList[index]);
                },
                separatorBuilder: (BuildContext _context, int index) {
                  return Container(
                      height: 1, color: Color.fromARGB(150, 163, 155, 155));
                },
                itemCount: favoritesList.length),
          );
        }
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: null, body: _bodyWidget());
  }
}
