import 'package:flutter/cupertino.dart';
import 'package:newsapi_49/model/news_model.dart';
import 'package:newsapi_49/service/news_api_service.dart';
import 'package:provider/provider.dart';

class NewsProvider with ChangeNotifier {
  List<Articles> newsList = [];
  List<Articles> searchList = [];

  Future<List<Articles>> getNewsData(
      {required int page, required String sortby}) async {
    newsList = await NewsApiService.fetchNewsData(page: page, sortby: sortby);
    return newsList;
  }

  Articles findByDate({String? date}) {
    Articles data =
        newsList.firstWhere((element) => element.publishedAt == date);
    return data;
  }

  Future<List<Articles>> getSearchData({required String query}) async {
    searchList = await NewsApiService.fetcSearchData(query: query);
    notifyListeners();
    return searchList;
  }
}
