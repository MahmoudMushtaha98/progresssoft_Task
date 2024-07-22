part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class LoadDataEvent extends HomeEvent {}

class DataLoadedEvent extends HomeEvent {
  final List<PostModel> postModel;

  DataLoadedEvent(this.postModel);
}

class SearchEvent extends HomeEvent{
  final String textSearch;
  final List<PostModel> postModel;

  SearchEvent(this.textSearch, this.postModel);
}

class LogoutEvent extends HomeEvent {}

class SuccessfullyEvent extends HomeEvent {}

