import 'package:borsanet/app/locator.dart';
import 'package:borsanet/models/analyst_model.dart';
import 'package:borsanet/services/api_service.dart';
import 'package:flutter/material.dart';

class AnalystViewmodel extends ChangeNotifier {
  final _apiService = locator<ApiService>();

  StockData? _detail;
  StockData? get detail => _detail;

  void getStock() async {
    _detail = await _apiService.getAnalist();
    notifyListeners();
  }

  void clearStock() {
    _detail = null;
    currentPageIndex = 1;
    notifyListeners();
  }

  bool loadMore = false;
  int currentPageIndex = 1;

  void setLoadMore(bool value) {
    loadMore = value;
    notifyListeners();
  }

  void getStockMore() async {
    if (loadMore) return;
    if (_detail == null || _detail!.after == null) return;
    int? afterPage = int.tryParse(_detail!.after!);
    print(currentPageIndex);
    print(afterPage);
    if(currentPageIndex >= afterPage!)return;

    Map<String, dynamic> args = {"page": _detail!.after};
    setLoadMore(true);

    final data = await _apiService.getAnalist(args: args);

    setLoadMore(false);
      currentPageIndex++;

    if (data != null) {
      _detail!.info.addAll(data.info);
      _detail!.after = data.after;
      notifyListeners();
    }
  }
}