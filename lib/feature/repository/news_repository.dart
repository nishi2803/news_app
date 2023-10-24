import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import '../models/article_model.dart';

class NewsRepository {

 /* Box<ArticleModel> newsBox = Hive.box<ArticleModel>('newsBox');*/

  Future<List<ArticleModel>> fetchNews() async {
    var response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=3795fc1071f14ab59f19637770ce867a"));

    var data = jsonDecode(response.body);
    List<ArticleModel> _articleModelList = [];
    if (response.statusCode == 200) {
      for (var item in data["articles"]) {
        ArticleModel _artcileModel = ArticleModel.fromJson(item);
        _articleModelList.add(_artcileModel);
        /*newsBox.add(_artcileModel);*/
      }
      return _articleModelList;
    } else {
      return _articleModelList;
    }
  }
  /*Future<List<ArticleModel>> getNewsFromHive() async {
    if (newsBox.isNotEmpty) {
      return newsBox.values.toList();
    }
    return [];
  }*/
}