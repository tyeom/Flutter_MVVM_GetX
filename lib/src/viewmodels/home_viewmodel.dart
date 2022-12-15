import 'package:get/get.dart';
import 'package:mvvm_getx_sample/src/models/article_model.dart';
import 'package:mvvm_getx_sample/src/services/data_service.dart';

class HomeViewModel extends GetxController {
  final DataService _dataService = Get.find<DataService>();

  // 데이터 요청중
  RxBool isDataFetching = false.obs;

  // ArticleModel 모델 리스트
  RxList<ArticleModel> _articleList = <ArticleModel>[].obs;
  List<ArticleModel>? get articleList => _articleList.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    this.fetchArticles();
  }

  // 데이터 요청
  void fetchArticles() async {
    // 데이터 요청중
    isDataFetching(true);

    List<ArticleModel>? articleList =
        await _dataService.fetchArticles('01077778888');

    // 데이터 요청 완료
    isDataFetching(false);

    if (articleList != null) {
      _articleList(articleList);
    }
  }

  // 데이터 추가
  void addArticles() {
    ArticleModel article = ArticleModel(
        id: null,
        title: '추가_테스트',
        content: '',
        town: '삼성동',
        price: 9999999,
        category: '기타',
        photoList: [
          'articles_image_picker8839652057073882499_1671054741520.jpeg',
          'articles_image_picker7685758608953263238_1671054741539.jpeg'
        ],
        favorites: false);

    _articleList.add(article);
  }

  // 즐겨찾기 목록 필터
  List<ArticleModel> getFavoritesList() {
    if (_articleList.value == null || _articleList.length <= 0) [];

    return _articleList.where((item) => item.favorites).toList();
  }

  void updateFavorites(String id, bool isFavorites) {
    ArticleModel? article =
        _articleList.firstWhereOrNull((element) => element.id == id);

    if (article != null) article.favorites = isFavorites;

    // GetX의 RxList는 Item요소의 변수값이 바뀌었는지 감지할 수 없다. [View에서 BindingStream 사용하지 않음]
    // 수동으로 refresh처리 해준다.
    _articleList.refresh();
  }
}
