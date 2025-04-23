import 'package:borsanet/models/analyst_model.dart';
import 'package:borsanet/models/news_model.dart';
import 'package:dio/dio.dart';

class ApiService {
   final _dio = Dio(BaseOptions(baseUrl: 'https://gannet-rich-opossum.ngrok-free.app/api'));

  Future<NewsModel?> getNews({String? url, Map<String, dynamic>? args}) async {
    try {
        final response = await _dio.post(url ?? '/news', queryParameters: args);
        print(response);
        return NewsModel.fromJson(response.data);
    } catch (e) {
        print("Error: " + e.toString());
        return null;
    }
}

Future<StockData?> getAnalist({String? url, Map<String, dynamic>? args}) async {
  try {
    final response = await _dio.post(url ?? '/analyst', queryParameters: args);
    
    print("Geldi: ${(response.data)}");
    print(response.data);
    print("API içerisi tamam");

    return StockData.fromJson(response.data);
  } catch (e) {
    print("Hataffffffff: $e");
    return null;
  }
}
Future<NewsModel?> getFavourites({String? url, Map<String, dynamic>? args}) async {
    try {
        final response = await _dio.post(url ?? '/favourites', queryParameters: args);
        return NewsModel.fromJson(response.data);
    } catch (e) {
        print("Error: " + e.toString());
        return null;
    }
}

Future<NewsItem?> getNewsDetail({String? url, Map<String, dynamic>? args}) async {
  try {
    final response = await _dio.post(url ?? '/news-detail', queryParameters: args);
      print("aaaaaa");
        return NewsItem.fromJson(response.data);
  } catch (e) {
    print("Error: " + e.toString());
    return null;
  }
}

Future<StockData?> getAnalystDetail({String? url, Map<String, dynamic>? args}) async {
  try {
    final response = await _dio.post(url ?? '/analyst-detail', queryParameters: args);
      print("aaaaaa");
        return StockData.fromJson(response.data);
  } catch (e) {
    print("Error: " + e.toString());
    return null;
  }
}

}