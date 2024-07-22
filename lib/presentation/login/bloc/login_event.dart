part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class StartLogInEvent extends LoginEvent {
  final String phone;
  final String pass;

  StartLogInEvent(this.phone, this.pass);
}

class SuccessfullyEvent extends LoginEvent {
  final RegisterModel registerModel;

  SuccessfullyEvent(this.registerModel);
}

class LogInFailed extends LoginEvent {
  final String error;

  LogInFailed(this.error);
}
