class ArticleModel {
  String title;
  String description;
  String urlToImage;
  DateTime publshedAt;
  String? content;
  String articleUrl;
  String? time;
  String source;

  ArticleModel({
    required this.title,
    required this.description,
    required this.content,
    required this.publshedAt,
    required this.urlToImage,
    required this.articleUrl,
    required this.source,
    this.time,
  });
}
