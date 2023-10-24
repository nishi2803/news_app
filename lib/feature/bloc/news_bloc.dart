
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_application/feature/models/article_model.dart';
import 'package:news_application/feature/bloc/news_event.dart';
import 'package:news_application/feature/bloc/news_state.dart';
import 'package:news_application/feature/repository/news_repository.dart';
import 'package:news_application/feature/service/news_service.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState>
{
  final NewsRepository newsRepository;


  NewsBloc(this.newsRepository) : super(NewsInitialState()){
    on<GetArticleEvent>(_getArticle);
    add(GetArticleEvent());

  }

  _getArticle(event, emit) async
  {
    try{
      List<ArticleModel> _articleList = [];
      emit(NewsLoadingState());
      _articleList = await newsRepository.fetchNews();
      emit( NewsLoadedState(_articleList));

    }
    catch(e)
    {
     emit(NewsErrorState(e.toString()));
    }
  }

}