import 'package:flutter/material.dart';
import 'package:news_app/helper/top_headline_news.dart';
import 'package:news_app/model/article_modle.dart';
import 'package:news_app/model/location.dart';
import 'package:news_app/model/sort_by.dart';

class TopHeadlineDataProvider extends ChangeNotifier {
  String currentSort = 'Popular';
  String currentLocation = CurrentLocation.india;
  List<ArticleModel> articles = [];
  bool loading = true;

  _getNews(String sortby) async {
    News news = News();
    await news.getNews(country: currentLocation, sortby: sortby);
    articles = news.news;
    loading = false;
  }

  onLocationChange(String location) async {
    loading = true;
    currentLocation = location;
    notifyListeners();
    await _getNews(currentSort);
    loading = false;
    notifyListeners();
  }

  onSortByChange(String sortby) async {
    currentSort = sortby;
    String setData = SortBy.popular;
    if (sortby == 'Popular') setData = SortBy.popular;
    if (sortby == 'Newest') setData = SortBy.newest;
    if (sortby == 'Oldest') setData = SortBy.oldest;
    loading = true;
    await _getNews(setData);
    notifyListeners();
  }

  onInitialize() async {
    await onSortByChange(currentSort);
  }

  onSourceChange(String source) {}
}
