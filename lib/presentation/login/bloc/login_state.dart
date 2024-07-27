part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoadingState extends LoginState{}

class SuccessfullyState extends LoginState{
  final RegisterModel registerModel;

  SuccessfullyState(this.registerModel);
}

class FailedState extends LoginState{}
