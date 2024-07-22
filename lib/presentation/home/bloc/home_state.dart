part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class LoadingState extends HomeState {}

class DataLoadedState extends HomeState {
  final List<PostModel> postModel;

  DataLoadedState(this.postModel);
}

class SearchState extends HomeState{
  final List<PostModel> postModel;
  final List<PostModel> filterPostModel;

  SearchState(this.postModel, this.filterPostModel);
}

class LogoutState extends HomeState {}

class SuccessfullyState extends HomeState {}
