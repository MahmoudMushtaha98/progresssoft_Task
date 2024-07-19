part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

class LoadingState extends RegisterState {}

class FailedState extends RegisterState {
  final String error;

  FailedState(this.error);
}

class OTPSentState extends RegisterState {
  final String otp;

  OTPSentState(this.otp);
}
