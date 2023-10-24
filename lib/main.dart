



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_application/feature/bloc/news_bloc.dart';
import 'package:news_application/feature/models/article_model.dart';
import 'package:news_application/feature/screens/home_screen.dart';
import 'package:news_application/feature/repository/news_repository.dart';
import 'package:news_application/feature/service/news_service.dart';

Future<void> main() async {
  final newsRepository = NewsRepository();
  final newsBloc = NewsBloc(newsRepository);

  await Hive.initFlutter();
  Hive.registerAdapter(ArticleModelAdapter());
  await Hive.openBox<ArticleModel>('newsBox');


  runApp(MyApp(newsBloc: newsBloc));
}

class MyApp extends StatelessWidget {
  final NewsBloc newsBloc;

  const MyApp({required this.newsBloc});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => newsBloc,
        child: HomeScreen(),
      ),
    );
  }
}