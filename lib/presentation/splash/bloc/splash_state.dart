part of 'splash_bloc.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}

class SuccessfullyState extends SplashState {
  final String data;

  SuccessfullyState(this.data);
}

class FirstVisitState extends SplashState {}
