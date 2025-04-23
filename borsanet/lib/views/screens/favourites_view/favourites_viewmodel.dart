import 'package:borsanet/app/locator.dart';
import 'package:borsanet/models/news_model.dart';
import 'package:borsanet/services/api_service.dart';
import 'package:flutter/material.dart';

class FavouritesViewmodel extends ChangeNotifier{
  final _apiService = locator<ApiService>();

  NewsModel? _newsModel;
  NewsModel? get aNewsModel => _newsModel;

  void getNews(String name) async{
    Map<String, dynamic>? args = {"name": name};
    _newsModel = await _apiService.getFavourites(args: args);
    notifyListeners();

  }

  bool loadMore = false;
  int currentPageIndex = 1;

  void setLoadMore(bool value) {
    loadMore = value;
    notifyListeners();
  } 
  
  getCharactersMore() {}
}

  bool loadMore = false;
  int currentPageIndex = 1;

  void setLoadMore(bool value) {
    loadMore = value;
    // notifyListeners();
  } 

  void getCharactersMore() async {
    if (loadMore) return;

  }
