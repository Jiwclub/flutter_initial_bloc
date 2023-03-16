import 'package:flutter_initial_bloc/network/dio_client.dart';

import '../data_provider/news_provider.dart';
import '../models/news_model.dart';

abstract class NewsRepositories {
  Future<NewsModel?> getNews();
}

class NewsRepositoriesImpl implements NewsRepositories {
  late NewsApi newsApi;

  NewsRepositoriesImpl() {
    newsApi = NewsApiImpl(dioClient: DioClient());
  }

  @override
  Future<NewsModel?> getNews() {
    return newsApi.getNews();
  }
}
