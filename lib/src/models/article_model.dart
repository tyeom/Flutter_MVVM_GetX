class ArticleModel {
  final String? id;
  final List<String>? photoList;
  final String title;
  final String content;
  final String town;
  final num price;
  final int? likeCnt;
  final int? readCnt;
  final int? uploadTime;
  final int? updateTime;
  final String category;
  bool favorites;

  ArticleModel(
      {this.id,
      this.photoList,
      required this.title,
      required this.content,
      required this.town,
      required this.price,
      this.likeCnt,
      this.readCnt,
      this.updateTime,
      this.uploadTime,
      required this.category,
      required this.favorites});

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
      id: json['id'],
      photoList: json['photoList'].cast<String>(),
      title: json['title'],
      content: json['content'],
      town: json['town'],
      price: json['price'],
      likeCnt: json['likeCnt'],
      readCnt: json['readCnt'],
      uploadTime: json['uploadTime'],
      updateTime: json['updateTime'],
      category: json['category'],
      favorites: json['favorites'] == null ? false : json['favorites'] as bool);

  Map<String, dynamic> toJson() => {
        'photoList': photoList,
        'title': title,
        'content': content,
        'town': town,
        'price': price,
        'likeCnt': likeCnt,
        'readCnt': readCnt,
        'category': category,
        'favorites': favorites,
      };
}
