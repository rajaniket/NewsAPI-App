import 'package:flutter/material.dart';
import 'package:news_app/helper/search_news.dart';
import 'package:news_app/model/article_modle.dart';
import 'package:news_app/model/location.dart';

class SearchDataProvider extends ChangeNotifier {
  List<ArticleModel> articles = [];
  bool loading = false;

  _getNews(String search) async {
    SearchForNews news = SearchForNews();
    await news.getSearchNews(search);
    articles = news.news;
    loading = false;
  }

  onSearch(String search) async {
    loading = true;
    notifyListeners();
    await _getNews(search);
    notifyListeners();
  }
}
