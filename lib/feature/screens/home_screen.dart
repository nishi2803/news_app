
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:news_application/feature/models/article_model.dart';
import 'package:news_application/feature/bloc/news_bloc.dart';
import 'package:news_application/feature/bloc/news_state.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
          body: Stack(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: width * 0.03),
                      child: Text(
                        "NEWS",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey.withOpacity(0.7),
                      width: width,
                      margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                    )
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                margin: EdgeInsets.only(top: height * 0.08),
                child: BlocConsumer<NewsBloc, NewsState>(
                  listener: (context, state)
                    {
                      if (state is NewsLoadingState) {
                        Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  builder: (BuildContext context, NewsState state) {
                     if (state is NewsLoadedState) {
                      List<ArticleModel> _articleList = [];
                      _articleList = state.articleList;

                      return ListView.builder(
                          itemCount: _articleList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                  FlutterWebBrowser.openWebPage(
                                    url: _articleList[index].url,
                                    customTabsOptions: const  CustomTabsOptions(
                                      colorScheme: CustomTabsColorScheme.dark,
                                      instantAppsEnabled: true,
                                      showTitle: true,
                                      urlBarHidingEnabled: true,
                                    ),
                                  );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 1,
                                          color: Colors.grey,
                                          offset: Offset(0, 2),
                                          spreadRadius: 1)
                                    ]),
                                height: height * 0.15,
                                margin: EdgeInsets.only(
                                    bottom: height * 0.01,
                                    top: height * 0.01,
                                    left: width * 0.02,
                                    right: width * 0.02),
                                child: Row(
                                  children: [
                                    Container(
                                      width: width * 0.3,
                                      height: height * 0.15,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                _articleList[index].urlToImage ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSojwMMYZgtiupM4Vzdb5iBeE4b0Mamf3AgrxQJR19Xa4oIWV5xun9a02Ggyh4bZAurP_c&usqp=CAU",
                                              ),
                                              fit: BoxFit.cover)),

                                    ),
                                    SizedBox(
                                      width: width * 0.03,
                                    ),
                                    Container(
                                      height: height * 0.15,
                                      width: width * 0.55,
                                      padding: EdgeInsets.symmetric(
                                          vertical: height * 0.01),
                                      child: Text(
                                        _articleList[index].title,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    } else if (state is NewsErrorState) {
                      String error = state.error;
                      print(error);
                      return Center(child: Text(error));
                    } else {
                      return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.green,
                          ));
                    }
                  },
                ),
              )
            ],
          )),
    );
  }
}