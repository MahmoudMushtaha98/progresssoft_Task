part of 'splash_bloc.dart';

@immutable
sealed class SplashEvent {}

class FitchDataEvent extends SplashEvent {}

class FitchSuccessfullyEvent extends SplashEvent {
  final String data;

  FitchSuccessfullyEvent(this.data);
}


class FirstVisitEvent extends SplashEvent {}
