import 'package:borsanet/app/locator.dart';
import 'package:borsanet/models/analyst_model.dart';
import 'package:borsanet/models/news_model.dart';
import 'package:borsanet/services/api_service.dart';
import 'package:flutter/material.dart';

class DetailViewmodel extends ChangeNotifier {
    final _apiService = locator<ApiService>();

  StockData? _analystData;
  StockData? get analystData => _analystData;

  void getDetailAnalyst(String name) async {
    Map<String, dynamic>? args = {"name": name};

    _analystData = await _apiService.getAnalystDetail(args: args);
    print(_analystData);
    notifyListeners();
  }

  NewsItem? _newsData;
  NewsItem? get newsData => _newsData;

  void getDetailNews(String name) async {
    Map<String, dynamic>? args = {"name": name};

    _newsData = await _apiService.getNewsDetail(args: args);
  
    notifyListeners();
  }
}