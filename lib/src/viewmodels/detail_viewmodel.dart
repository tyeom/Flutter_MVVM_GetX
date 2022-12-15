import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:mvvm_getx_sample/src/models/article_model.dart';
import 'package:mvvm_getx_sample/src/services/data_service.dart';

class DetailViewModel extends GetxController {
  final DataService _dataService = Get.find<DataService>();

  // 데이터 요청중
  RxBool isDataFetching = false.obs;

  // ArticleModel 모델
  final Rx<ArticleModel?> _article = ArticleModel(
          title: '',
          content: '',
          town: '',
          price: 0,
          category: '',
          favorites: false)
      .obs;
  ArticleModel? get article => _article.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  // 데이터 요청
  void fetchDetailArticle(String id) async {
    // 데이터 요청중
    isDataFetching(true);

    ArticleModel? article = await _dataService.fetchDetailArticle(id);

    // 데이터 요청 완료
    isDataFetching(false);

    _article(article);
  }

  // 데이터 삭제
  Future<bool> removeArticle(String id) async {
    bool removeResult = await _dataService.removeArticle(id);
    return removeResult;
  }
}
