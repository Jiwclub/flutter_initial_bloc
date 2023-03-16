import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_initial_bloc/data/models/news_model.dart';
import 'package:flutter_initial_bloc/data/repositories/news_repositories.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late NewsRepositories repo;
  HomeBloc() : super(HomeInitial()) {
    repo = NewsRepositoriesImpl();

    on<HomeEvent>((event, emit) async {
      log('GetUsersEvent $event');
      emit(NewsLoading());
      final res = await repo.getNews();
      emit(NewsSuccess(res?.products));
    });
  }
}
