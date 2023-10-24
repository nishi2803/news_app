import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'article_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class ArticleModel {
  @HiveField(0)
  Source source;

  @HiveField(1)
  String author;

  @HiveField(2)
  String title;

  @HiveField(3)
  String description;

  @HiveField(4)
  String url;

  @HiveField(5)
  String? urlToImage;

  @HiveField(6)
  String publishedAt;

  @HiveField(7)
  String content;

  ArticleModel(
      {required this.source,
      required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content});
  factory ArticleModel.fromJson(Map<String, dynamic> data) {
    return ArticleModel(
      source: Source.fromJson(data['source']),
      author: data['author'] as String? ?? '',
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      url: data['url'] as String? ?? '',
      urlToImage: data['urlToImage'] as String?,
      publishedAt: data['publishedAt'] as String? ?? '',
      content: data['content'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}
@JsonSerializable()
class Source {
  String id;
  String name;

  Source({required this.id, required this.name});

  factory Source.fromJson(Map<String, dynamic> data)
  {
    return Source(
      id: data['id'] as String? ?? '', // Handle null id
      name: data['name'] as String? ?? '', // Handle null name
    );
  }

  Map<String, dynamic> toJson() => _$SourceToJson(this);
}
