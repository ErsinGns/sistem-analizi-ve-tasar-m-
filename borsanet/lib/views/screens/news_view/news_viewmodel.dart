import 'package:borsanet/app/locator.dart';
import 'package:borsanet/models/news_model.dart';
import 'package:borsanet/services/api_service.dart';
import 'package:flutter/material.dart';

class NewsViewmodel extends ChangeNotifier {
 final _apiService = locator<ApiService>();

  NewsModel? _newsModel;
  NewsModel? get newsModel => _newsModel;

  void getNews() async{
    _newsModel = await _apiService.getNews();
    print(_newsModel);
    notifyListeners();
  }

  void clearNews() async{
    _newsModel = null;
    currentPageIndex = 1;
    notifyListeners();
  }

  bool loadMore = false;
  int currentPageIndex = 1;

  void setLoadMore(bool value) {
    loadMore = value;
    notifyListeners();
  } 

  void getNewsMore() async {
    if (loadMore) return;
    if(_newsModel?.after == null) return;
    int? afterPage = int.tryParse(_newsModel!.after!);
    print(currentPageIndex);
    print(afterPage);
    if(currentPageIndex > afterPage!)return;
    Map<String, dynamic> args = {"page": _newsModel!.after};
    setLoadMore(true);
    final data =
        await _apiService.getNews(args: args);

    setLoadMore(false);

    currentPageIndex++;
    
    _newsModel!.after = data?.after;

    _newsModel!.news.addAll(data!.news);
  }



}