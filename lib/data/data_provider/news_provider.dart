import 'dart:developer';

import 'package:flutter_initial_bloc/network/dio_client.dart';

import '../models/news_model.dart';

abstract class NewsApi {
  Future<NewsModel?> getNews();
}

class NewsApiImpl implements NewsApi {
  final DioClient dioClient;
  NewsApiImpl({required this.dioClient});

  @override
  Future<NewsModel?> getNews() async {
    try {
      final res = await dioClient.get(
        '/products',
      );

      return NewsModel.fromJson(res);
    } on Exception {
      return null;
    }
  }
}
