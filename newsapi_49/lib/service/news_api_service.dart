import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapi_49/model/news_model.dart';

class NewsApiService {
  static Future<List<Articles>> fetchNewsData(
      {required int page, required String sortby}) async {
    List<Articles> newsList = [];
    try {
      var link =
          "https://newsapi.org/v2/everything?q=bitcoin&apiKey=1039e6f90e5a4cb2a6193bcb7a1127b4&pageSize=10&page=$page&sortBy=$sortby";
      var responce = await http.get(Uri.parse(link));
      print("responce is ${responce.body}");
      var data = jsonDecode(responce.body);
      Articles articles;
      for (var i in data["articles"]) {
        articles = Articles.fromJson(i);
        newsList.add(articles);
      }
    } catch (e) {
      print("the problem is $e");
    }
    return newsList;
  }

  static Future<List<Articles>> fetcSearchData({required String query}) async {
    List<Articles> searchList = [];
    try {
      var link =
          "https://newsapi.org/v2/everything?q=$query&apiKey=1039e6f90e5a4cb2a6193bcb7a1127b4";
      var responce = await http.get(Uri.parse(link));
      print("responce is ${responce.body}");
      var data = jsonDecode(responce.body);
      Articles articles;
      for (var i in data["articles"]) {
        articles = Articles.fromJson(i);
        searchList.add(articles);
      }
    } catch (e) {
      print("the problem is $e");
    }
    return searchList;
  }
}
