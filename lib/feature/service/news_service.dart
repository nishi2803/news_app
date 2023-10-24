

import 'package:news_application/feature/models/article_model.dart';
import 'package:news_application/feature/repository/news_repository.dart';

class NewsService {
  final NewsRepository repository;

  NewsService(this.repository);

  Future<List<ArticleModel>> getNews() async {
    return repository.fetchNews();
  }
}