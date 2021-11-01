import 'dart:convert';

import 'package:news_app/model/article_modle.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];
  Future<void> getNews(
      {required String sortby, required String country}) async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=$country&sortBy=$sortby&apiKey=98556e1522d6480991fda6ced43c2721';
    print(url);
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
            source: element['source']['name'],
          );

          news.add(articleModel);
        }
      });
    }
  }
}
