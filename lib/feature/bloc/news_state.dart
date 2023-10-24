
import 'package:news_application/feature/models/article_model.dart';

abstract class NewsState {}

class NewsInitialState extends NewsState{}

class NewsLoadingState extends NewsState{}

class NewsLoadedState extends NewsState{
  List<ArticleModel> articleList;
  NewsLoadedState(this.articleList);
}
class NewsErrorState extends NewsState
{
  String error;
  NewsErrorState(this.error);
}