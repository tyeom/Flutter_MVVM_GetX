import 'package:mvvm_getx_sample/src/helper/http_helper.dart';
import 'package:mvvm_getx_sample/src/models/article_model.dart';

class DataService {
  // 아티클 리스트 데이터 요청
  Future<List<ArticleModel>?> fetchArticles(String phoneNum) async {
    print('데이터 요청');

    // http://arong.info:7004/ArticlesByPhonenum?phoneNum=01011112222
    final responseJson = await HttpHelper.requestHttpFromJson(
        HttpRequestMethod.GET,
        '/ArticlesByPhonenum',
        {'phoneNum': phoneNum},
        null);
    if (responseJson == null) {
      return null;
    } else {
      return parseArticles(responseJson);
    }
  }

  // 아티클 리스트 json to list parser
  List<ArticleModel> parseArticles(dynamic jsonMap) {
    if (jsonMap.containsKey("rows")) {
      final articleList = jsonMap["rows"]
          .map<ArticleModel>((json) => ArticleModel.fromJson(json))
          .toList();
      return articleList;
    } else {
      // 데이터 없음.
      return [];
    }
  }

  // 아티클 상세 데이터 요청
  Future<ArticleModel?> fetchDetailArticle(String id) async {
    print('상세 데이터 요청');

    // http://arong.info:7004/DetailArticle/{articleKey}
    final responseJson = await HttpHelper.requestHttpFromJson(
        HttpRequestMethod.GET, '/DetailArticle/$id', null, null);
    if (responseJson == null) {
      return null;
    } else {
      return ArticleModel.fromJson(responseJson);
    }
  }

  // 아티클 데이터 삭제
  Future<bool> removeArticle(String id) async {
    print('데이터 삭제');

    // http://arong.info:7004/removeArticle/{articleKey}
    final responseBody = await HttpHelper.requestHttp(
        HttpRequestMethod.GET, '/removeArticle/$id', null, null);
    if (responseBody == null) {
      return false;
    } else {
      return (responseBody == 'ok');
    }
  }
}
